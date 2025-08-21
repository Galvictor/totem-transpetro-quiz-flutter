import 'package:flutter/material.dart';
import '../widgets/video_background.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final VideoBackgroundController _videoController =
      VideoBackgroundController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: VideoBackground(
        // Vídeo de fundo para a página intro
        videoPath: 'assets/videos/Ofical+A+-+fala+1+-+com+intro.mp4',
        // Imagem de fallback enquanto carrega
        fallbackImagePath: 'assets/images/capa.png',
        // Configurações do vídeo
        autoplay: true, // Autoplay ativo para iniciar automaticamente
        loop: false, // Não fica em loop
        volume: 1.0, // Volume máximo
        fit: BoxFit.cover,
        // Controller para controle externo
        controller: _videoController,
        // Callbacks para eventos
        onVideoReady: () {
          debugPrint('Vídeo da Intro carregado com sucesso!');
        },
        onVideoError: () {
          debugPrint('Erro ao carregar vídeo da Intro');
        },
        onVideoFinished: () {
          debugPrint('🎬 Vídeo da Intro terminou!');
          debugPrint('✅ Pronto para próxima ação!');
        },
        // Conteúdo sobreposto ao vídeo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título
              const Text(
                'Bem-vindo ao Jogo!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Descrição
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Esta é a página de introdução do seu jogo.\nAqui você pode adicionar instruções, história ou qualquer conteúdo inicial.',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 60),

              // Botão para voltar
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Volta para a página anterior
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Voltar', style: TextStyle(fontSize: 18)),
              ),

              const SizedBox(height: 20),

              // Botão para continuar (você pode personalizar)
              ElevatedButton(
                onPressed: () {
                  // Aqui você pode navegar para a próxima tela do jogo
                  debugPrint('Continuar para o jogo!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text('Continuar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
