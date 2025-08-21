import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// Controller para controlar o vídeo de fora do widget
class VideoBackgroundController {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _isPlaying = false;

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _isPlaying;

  void _setController(VideoPlayerController controller) {
    _controller = controller;
  }

  void _setInitialized(bool initialized) {
    _isInitialized = initialized;
  }

  void _setPlaying(bool playing) {
    _isPlaying = playing;
  }

  Future<void> play() async {
    if (_controller != null && _isInitialized) {
      await _controller!.play();
      _setPlaying(true);
    }
  }

  Future<void> pause() async {
    if (_controller != null && _isInitialized) {
      await _controller!.pause();
      _setPlaying(false);
    }
  }

  Future<void> stop() async {
    if (_controller != null && _isInitialized) {
      await _controller!.pause();
      await _controller!.seekTo(Duration.zero);
      _setPlaying(false);
    }
  }

  Future<void> setVolume(double volume) async {
    if (_controller != null && _isInitialized) {
      await _controller!.setVolume(volume);
    }
  }
}

class VideoBackground extends StatefulWidget {
  final String videoPath;
  final String? fallbackImagePath;
  final bool autoplay;
  final bool loop;
  final double volume;
  final BoxFit fit;
  final Widget? child;
  final VoidCallback? onVideoReady;
  final VoidCallback? onVideoError;
  final VoidCallback? onVideoFinished;
  final VideoBackgroundController? controller;

  const VideoBackground({
    super.key,
    required this.videoPath,
    this.fallbackImagePath,
    this.autoplay = true,
    this.loop = true,
    this.volume = 0.0,
    this.fit = BoxFit.cover,
    this.child,
    this.onVideoReady,
    this.onVideoError,
    this.onVideoFinished,
    this.controller,
  });

  @override
  State<VideoBackground> createState() => _VideoBackgroundState();
}

class _VideoBackgroundState extends State<VideoBackground> {
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
      debugPrint('Iniciando carregamento do vídeo: ${widget.videoPath}');
      debugPrint(
        'Configurações: autoplay=${widget.autoplay}, loop=${widget.loop}, volume=${widget.volume}',
      );

      // Limpa estado anterior
      if (mounted) {
        setState(() {
          _isVideoInitialized = false;
          _hasError = false;
          _videoStarted = false;
        });
      }

      // Cria controller baseado no tipo de vídeo
      if (widget.videoPath.startsWith('http')) {
        // URL externa
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(widget.videoPath),
        );
      } else {
        // Asset local
        _videoPlayerController = VideoPlayerController.asset(widget.videoPath);
      }

      // Conecta o controller externo se fornecido
      if (widget.controller != null) {
        widget.controller!._setController(_videoPlayerController!);
      }

      await _videoPlayerController!.initialize();
      debugPrint('Vídeo inicializado com sucesso!');
      debugPrint('Dimensões: ${_videoPlayerController!.value.size}');

      // Configura volume e loop
      await _videoPlayerController!.setVolume(widget.volume);
      await _videoPlayerController!.setLooping(widget.loop);

      // Adiciona listener para detectar fim do vídeo
      _addVideoListener();

      // Atualiza o controller externo
      if (widget.controller != null) {
        widget.controller!._setInitialized(true);
      }

      // Tenta autoplay se habilitado
      if (widget.autoplay) {
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
          // Atualiza o controller externo
          if (widget.controller != null) {
            widget.controller!._setPlaying(true);
          }
          widget.onVideoReady?.call();
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
      } else {
        // Sem autoplay - vídeo fica pronto mas não reproduz
        debugPrint('Autoplay desabilitado - vídeo aguardando interação');
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            _videoStarted = false;
            _hasError = false;
          });
        }
        widget.onVideoReady?.call();
      }

      debugPrint('Vídeo carregado e pronto para reprodução!');
    } catch (e) {
      debugPrint('Erro ao carregar vídeo: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
      widget.onVideoError?.call();
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
    // Remove o listener antes de dispor
    _videoPlayerController?.removeListener(_videoListener);
    _videoPlayerController?.dispose();
    super.dispose();
  }

  // Listener separado para evitar recriação
  void _videoListener() {
    if (!mounted || _videoPlayerController == null) return;

    // Verifica se o vídeo terminou
    if (_videoPlayerController!.value.position >=
        _videoPlayerController!.value.duration) {
      if (_videoPlayerController!.value.duration > Duration.zero) {
        debugPrint(
          '🎬 Vídeo terminou! Duração: ${_videoPlayerController!.value.duration}',
        );
        debugPrint(
          '📍 Posição final: ${_videoPlayerController!.value.position}',
        );

        // Atualiza o controller externo
        if (widget.controller != null) {
          widget.controller!._setPlaying(false);
        }

        // Atualiza o estado local
        if (mounted) {
          setState(() {
            _videoStarted = false;
          });
        }
        widget.onVideoFinished?.call();
      }
    }
  }

  void _addVideoListener() {
    if (_videoPlayerController != null) {
      _videoPlayerController!.addListener(_videoListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Vídeo de fundo ou fallback
        if (_isVideoInitialized &&
            _videoPlayerController != null &&
            _videoStarted)
          SizedBox.expand(
            child: FittedBox(
              fit: widget.fit,
              child: SizedBox(
                width: _videoPlayerController!.value.size.width,
                height: _videoPlayerController!.value.size.height,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
          )
        else if (_hasError)
          // Fallback quando há erro no vídeo
          SizedBox.expand(
            child: Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.white,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Erro ao carregar vídeo',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.videoPath,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          )
        else
          // Fallback enquanto carrega ou aguarda interação
          SizedBox.expand(
            child: Stack(
              children: [
                // Imagem de fallback se fornecida
                if (widget.fallbackImagePath != null)
                  SizedBox.expand(
                    child: Image.asset(
                      widget.fallbackImagePath!,
                      fit: widget.fit,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint(
                          'Erro ao carregar imagem de fallback: $error',
                        );
                        return Container(color: Colors.black);
                      },
                    ),
                  )
                else
                  // Fundo preto padrão
                  Container(color: Colors.black),

                // Overlay escuro para melhorar legibilidade
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_isVideoInitialized) ...[
                          const Text(
                            'Vídeo carregado! Clique no botão para iniciar.',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          // Botão para iniciar vídeo
                          IconButton(
                            onPressed: _startVideo,
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 48,
                            ),
                            tooltip: 'Iniciar Vídeo',
                          ),
                        ] else ...[
                          const CircularProgressIndicator(color: Colors.white),
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

        // Conteúdo sobreposto (child)
        if (widget.child != null) widget.child!,
      ],
    );
  }
}
