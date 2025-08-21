import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponsivePlayButton extends StatelessWidget {
  final VoidCallback onTap;
  final double bottomPosition;

  const ResponsivePlayButton({
    super.key,
    required this.onTap,
    this.bottomPosition = 400,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomPosition,
      left: 0,
      right: 0,
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Calcula tamanho responsivo baseado na tela
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;

            // Base: 435x172 em 1080x1920
            // Calcula proporção para outras resoluções
            final baseWidth = 435.0;
            final baseHeight = 172.0;
            final baseScreenWidth = 1080.0;

            // Escala baseada na largura da tela (1080 -> 435)
            final scaleFactor = screenWidth / baseScreenWidth;

            // Aplica escala mantendo proporção original
            final buttonWidth = baseWidth * scaleFactor;
            final buttonHeight = baseHeight * scaleFactor;

            // Limita o tamanho mínimo e máximo
            final finalWidth = buttonWidth.clamp(200.0, 600.0);
            final finalHeight = buttonHeight.clamp(80.0, 240.0);

            return GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: finalWidth,
                height: finalHeight,
                child: SvgPicture.asset(
                  'assets/images/botao-jogar.svg',
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
