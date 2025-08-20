import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Jogo Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController? _videoPlayerController;
  bool _isVideoInitialized = false;
  bool _hasError = false;
  bool _videoStarted = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() async {
    try {
      debugPrint('Iniciando carregamento do vídeo...');
      _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/abdias-video-capa.mp4',
      );

      await _videoPlayerController!.initialize();
      debugPrint('Vídeo inicializado com sucesso!');
      debugPrint('Dimensões: ${_videoPlayerController!.value.size}');

      // Desabilita o áudio e tenta autoplay
      await _videoPlayerController!.setVolume(0.0);
      await _videoPlayerController!.setLooping(true);

      // Tenta reproduzir automaticamente
      try {
        await _videoPlayerController!.play();
        debugPrint('Autoplay funcionou!');
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            _videoStarted = true;
            _hasError = false;
          });
        }
      } catch (autoplayError) {
        debugPrint('Autoplay falhou, aguardando interação: $autoplayError');
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            _videoStarted = false;
            _hasError = false;
          });
        }
      }

      debugPrint('Vídeo carregado e pronto para reprodução!');
    } catch (e) {
      debugPrint('Erro ao carregar vídeo: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _startVideo() async {
    if (_videoPlayerController != null && _isVideoInitialized) {
      await _videoPlayerController!.play();
      setState(() {
        _videoStarted = true;
      });
      debugPrint('Vídeo iniciado pelo usuário!');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  void _onPlayButtonPressed() {
    debugPrint('Botão Jogar pressionado!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Define dimensões máximas para formato vertical
        constraints: const BoxConstraints(maxWidth: 1080, maxHeight: 1920),
        child: Center(
          child: AspectRatio(
            // Força proporção 9:16 (vertical)
            aspectRatio: 9 / 16,
            child: Stack(
              children: [
                // Vídeo de fundo ou fallback
                if (_isVideoInitialized &&
                    _videoPlayerController != null &&
                    _videoStarted)
                  SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoPlayerController!.value.size.width,
                        height: _videoPlayerController!.value.size.height,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                    ),
                  )
                else if (_hasError)
                  // Fallback quando há erro no vídeo
                  Container(
                    color: Colors.black,
                    child: const Center(
                      child: Text(
                        'Erro ao carregar vídeo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  // Fallback enquanto carrega ou aguarda interação
                  Container(
                    color: Colors.black,
                    child: Stack(
                      children: [
                        // Imagem de capa como fundo
                        SizedBox.expand(
                          child: Image.asset(
                            'assets/images/capa.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Overlay escuro para melhorar legibilidade do texto
                        Container(
                          color: Colors.black54,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_isVideoInitialized) ...[
                                  const Text(
                                    'Vídeo carregado! Se não aparecer automaticamente,\nclique no botão de play no canto inferior direito.',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ] else ...[
                                  const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    'Carregando vídeo...',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Botão SVG centralizado
                Center(
                  child: GestureDetector(
                    onTap: _onPlayButtonPressed,
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: SvgPicture.asset(
                        'assets/images/botao-jogar.svg',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),

                // Botão Iniciar Vídeo discreto (só aparece se autoplay falhar)
                if (_isVideoInitialized && !_videoStarted)
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        onPressed: _startVideo,
                        icon: const Icon(Icons.play_arrow, color: Colors.white),
                        tooltip: 'Iniciar Vídeo de Fundo',
                      ),
                    ),
                  ),

                // Debug info (remover em produção)
                Positioned(
                  top: 40,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black54,
                    child: Text(
                      'Status: ${_isVideoInitialized
                          ? (_videoStarted ? "Vídeo Reproduzindo" : "Aguardando Clique")
                          : _hasError
                          ? "Erro"
                          : "Carregando"}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
