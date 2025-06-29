# bloblist

TodoList x Tamagochi

## Principe

Le but de cette mini application est de présenter une fonctionnalité simple et a été fate dans un temps limité.

La fonctionnalité est basique aussi, en réalisant des tâches, on fait progresser notre blob (Un slime de Dragon Quest)
il peut monter de niveau et gagner des caractéristiques.

Le but à terme d'une appli de ce type est de renforcer l'assiduité dans les tâches et se comparer aux autres.

À cet effet, l'architecture même de l'application reflète ce désir.

## Notes rapides

Je suis parti 'from scratch', sans même Flutter ou Visual Studio installé et
je n'ai utilisé qu'un peu de code d'exemple issu de la documentation officielle.
Le but étant de partir sur un état le plus 'clean' possible

## Ce que l'app contient sans qu'on le voit vraiment

- Un moteur audio
- Une vue 3D via une webview
- La possibilité de charger des fichiers JSON pour l'autocomplete des tasks
- Un système de debug en local (Plus de détails dessous)
- Des configurations multiples
- Un Router
- Une architecture MVVM étendable
- Des classes basiques
- Un serializer json pour stocker localement les données
- Un système de provider pour pouvoir améliorer l'interopérabilité des données
- Une compatibilité Android 12
- Un design personnalisable
- Une implémentation i18n pour la majorité des textes
- Un logger basique pour le debugging
- Des validateurs locaux pour l'inscription
- La gestion de fichiers JSON pour gérer l'autocomplétion

## Ce qu'il manque

- Une lib HTTP pour faire des appels réseaux
- Un obfuscateur [Flutter doc](https://docs.flutter.dev/deployment/obfuscate) pour la cyber-sécurité
- Une intégration avec Firebase/Crashlytics
- Une configuration de production qui utilise le réseau
- Les pages stats et leaderboard
- L'accès aux contacts pour le leaderboard
- L'autocompletion pour la todolist (malgré la présence du fichier .json)
- Un beau design
- Un icône compatible Android 12 pour le splash
- L'animation du slime après un level-up
- Les tests unitaires

## Choix

- Flutter:
    J'ai pris Flutter pour son côté multiplateforme est sa facilité de développement.
    Même si je m'y connais que très peu, Flutter est super rapide à prendre en main,
    une journée de formation suffit pour permettre à n'importe quel développeur mobile de travailler dessus.
    De plus le support de Flutter (librairies, documentation, communauté) est très complet.
    Les développeurs Flutter sont des développeurs mobiles (contrairement aux développeurs React Native qui sont généralement des développeurs
    web avant tout) donc pour une continuité cela représente une logique péremptoire.

- i18n:
    Meilleur format de localisation et d'internationalisation, permet de facilement ajouter de nouveaux langages.
    Je trouve ça indispensable à intégrer en début de développement, cela force une habitude et permet d'éviter les intraduits au moment
    de la release. Même si une appli ne supporte que le français, je préfère mettre i18n dès le début. Le coût en terme de développement est léger.

- Le modèle MVVM:
    C'est le modèle d'architecture classique du développement mobile.
    Il sépare les vues de leurs vue-modèles et des modèles; les responsabilités sont séparées ce qui permet d'être plus lisible et évolvable.
    Tout développeur mobile sait se repérer avec cette architecture, ce qui permet des ajouts faciles, des tests faciles et une rapidité de développement malgré une mise en place longue.
    Additionnellement, les fichiers sont plus courts, c'est agréable.

- Usage de l'IA:
    J'ai utilisé Gemini pour les parties simples et répétitives du code pour gagner du temps.
    Gemini, de Google, fonctionne très bien avec Flutter (de Google) et peut intégrer des classes et des morceaux d'UI basiques presque instantanément.
    Je m'en suis aussi servi pour faire des résumés rapides de la documentation pour gagner encore plus de temps.

- La gestion en local des données:
    Permet de tester rapidement l'UI de l'application.
    En plus, avec les configurations multiples, cela permet au développeur de tester différents cas (Sans réseau - Serveur dev - Serveur prod)
    Je préfère mettre cela en place dès le début car ajouter cela en cours de route augmente la complexité.

Globalement, tout ce qui est ajouté en début de production permet d'économiser beaucoup de temps sur le long terme.
Le coût de telles intégrations en 'cours de route' est élevé et présente un risque.
Pour ne pas compromettre les ajouts futurs, je trouve important de prioriser l'architecture.
La majorité du temps de développement du projet a été passé dessus; j'ai préféré faire le moins de compromis possible là-dessus.
Cela facilite aussi l'ajout de fonctionnalité et tout nouveau code: Il suffit de reprendre ce qui a été fait car presque tout existe et tout est rangé.
L'architecture de ce projet est aussi copiable pour tout autre nouveau projet flutter (Faut juste enlever le blob en 3D)

# Avec plus de temps

J'aurais ajouté en priorité les fonctionnalités réseau avant de m'attaquer aux pages secondaires.
Le design et les animations seraient les dernières intégration.