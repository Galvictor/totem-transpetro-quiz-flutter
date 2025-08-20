# 🎮 Meu Jogo Flutter

Um projeto Flutter moderno com vídeo de fundo em loop e interface interativa usando SVG.

## ✨ Funcionalidades

-   **🎥 Vídeo de fundo automático** em loop (sem áudio)
-   **🎯 Botão SVG centralizado** e responsivo
-   **📱 Interface adaptativa** para diferentes dispositivos
-   **🌐 Suporte completo** para Web, Android, iOS, Windows, macOS e Linux
-   **⚡ Autoplay inteligente** com fallback automático
-   **📐 Formato vertical otimizado** (9:16) com dimensões máximas 1080x1920

## 🚀 Como executar

### Pré-requisitos

-   Flutter SDK 3.9.0 ou superior
-   Dart SDK
-   Chrome/Edge (para desenvolvimento web)

### Instalação

```bash
# Clone o repositório
git clone [URL_DO_SEU_REPOSITORIO]
cd flutter_hello_world

# Instale as dependências
flutter pub get

# Execute o projeto
flutter run -d chrome    # Para web
flutter run               # Para dispositivo conectado
```

## 🎯 Plataformas suportadas

| Plataforma | Status         | Comando                  |
| ---------- | -------------- | ------------------------ |
| 🌐 Web     | ✅ Funcionando | `flutter run -d chrome`  |
| 📱 Android | ✅ Funcionando | `flutter run -d android` |
| 🍎 iOS     | ✅ Funcionando | `flutter run -d ios`     |
| 🪟 Windows | ✅ Funcionando | `flutter run -d windows` |
| 🖥️ macOS   | ✅ Funcionando | `flutter run -d macos`   |
| 🐧 Linux   | ✅ Funcionando | `flutter run -d linux`   |

## 🏗️ Estrutura do projeto

```
flutter_hello_world/
├── lib/
│   └── main.dart          # Arquivo principal da aplicação
├── assets/
│   ├── images/
│   │   ├── botao-jogar.svg    # Botão SVG centralizado
│   │   └── capa.png           # Imagem de capa (fallback)
│   └── videos/
│       └── abdias-video-capa.mp4  # Vídeo de fundo
├── pubspec.yaml           # Dependências e configurações
└── README.md              # Este arquivo
```

## 📦 Dependências

```yaml
dependencies:
    flutter:
        sdk: flutter
    video_player: ^2.8.3 # Reprodução de vídeo
    flutter_svg: ^2.0.10+1 # Suporte a SVG
    cupertino_icons: ^1.0.8 # Ícones iOS
```

## 🎨 Características técnicas

### Vídeo de fundo

-   **Formato**: MP4
-   **Reprodução**: Loop automático
-   **Áudio**: Desabilitado (para permitir autoplay)
-   **Adaptação**: Cover para preencher toda a tela

### Imagem de capa (Fallback)

-   **Formato**: PNG
-   **Função**: Fallback visual enquanto o vídeo carrega
-   **Posicionamento**: Fundo da tela com overlay escuro
-   **Adaptação**: Cover para preencher toda a tela

### Botão SVG

-   **Formato**: SVG vetorial
-   **Tamanho**: 200x200 pixels
-   **Posicionamento**: Centralizado na tela
-   **Interatividade**: Clique responsivo

### Interface

-   **Tema**: Material Design 3
-   **Cores**: Esquema baseado em roxo profundo
-   **Layout**: Stack com sobreposição inteligente
-   **Responsividade**: Adapta-se a diferentes resoluções

### Formato e Dimensões

-   **Orientação**: Vertical (retrato)
-   **Proporção**: 9:16 (aspect ratio)
-   **Dimensões máximas**: 1080x1920 pixels
-   **Otimização**: Mobile-first e web responsivo
-   **Centragem**: Sempre centralizado na tela

## 🔧 Desenvolvimento

### Hot Reload

```bash
# Durante a execução, pressione 'r' para hot reload
# Pressione 'R' para hot restart
# Pressione 'q' para sair
```

### Build para produção

```bash
# Web
flutter build web

# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🐛 Solução de problemas

### Vídeo não aparece

1. Verifique se o arquivo está em `assets/videos/`
2. Confirme se o `pubspec.yaml` inclui a pasta de assets
3. Execute `flutter clean` e `flutter pub get`

### Botão SVG não carrega

1. Verifique se o arquivo está em `assets/images/`
2. Confirme se o `flutter_svg` está instalado
3. Verifique o console para erros

### Autoplay não funciona

-   **Web**: O vídeo deve aparecer automaticamente (sem áudio)
-   **Dispositivos**: Funciona normalmente em todas as plataformas

## 📱 Screenshots

_Adicione screenshots do seu projeto aqui_

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 👨‍💻 Autor

**Seu Nome**

-   GitHub: [@seu-usuario](https://github.com/seu-usuario)
-   LinkedIn: [Seu Nome](https://linkedin.com/in/seu-perfil)

## 🙏 Agradecimentos

-   Flutter Team pelo framework incrível
-   Comunidade Flutter pela documentação e suporte
-   Contribuidores do projeto

---

⭐ **Se este projeto te ajudou, considere dar uma estrela!** ⭐
