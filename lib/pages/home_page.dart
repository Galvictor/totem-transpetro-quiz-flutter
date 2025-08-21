import 'package:flutter/material.dart';
import '../widgets/video_background.dart';
import '../widgets/responsive_button.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  void _onPlayButtonPressed(BuildContext context) {
    debugPrint('Botão Jogar pressionado!');
    // Navega para a página Intro
    Navigator.pushNamed(context, '/intro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove a AppBar para tela cheia
      body: VideoBackground(
        // Vídeo de fundo principal
        videoPath: 'assets/videos/loop.mp4',
        // Imagem de fallback enquanto carrega
        fallbackImagePath: 'assets/images/capa.png',
        // Configurações do vídeo
        autoplay: true,
        loop: true,
        volume: 0.0,
        fit: BoxFit.cover,
        // Callbacks para eventos
        onVideoReady: () {
          debugPrint('Vídeo principal carregado com sucesso!');
        },
        onVideoError: () {
          debugPrint('Erro ao carregar vídeo principal');
        },
        // Conteúdo sobreposto ao vídeo
        child: Stack(
          children: [
            // Botão SVG responsivo
            ResponsivePlayButton(
              onTap: () => _onPlayButtonPressed(context),
              bottomPosition: 400,
            ),

            // Debug info (remover em produção)
            Positioned(
              top: 40,
              left: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black54,
                child: const Text(
                  'Status: Vídeo Funcionando',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
