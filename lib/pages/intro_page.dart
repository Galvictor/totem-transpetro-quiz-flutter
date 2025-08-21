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
        videoPath: 'assets/videos/intro.mp4',
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
          debugPrint('✅ Voltando automaticamente para Home...');
          // Volta automaticamente para a Home
          Navigator.pop(context);
        },
        // Conteúdo sobreposto ao vídeo
        child: null, // Sem conteúdo sobreposto - apenas o vídeo de fundo
      ),
    );
  }
}
