class ServicesUtils {
  final String name;
  final String icon;
  final List<String> tool;
  final String description;

  ServicesUtils(
      {required this.name,
      required this.icon,
      required this.description,
      required this.tool});
}

List<ServicesUtils> servicesUtils = [
  ServicesUtils(
    name: 'Android App Development',
    icon: 'assets/icons/android.svg',
    description: "Developed Android applications using both Java and Flutter.",
    tool: ['Flutter', 'Android (Java)'],
  ),
  ServicesUtils(
    name: 'iOS App Development',
    icon: 'assets/icons/apple.svg',
    description:
        "Implemented state management solutions and integrated RESTful APIs for dynamic data handling.",
    tool: ['Flutter'],
  ),
  ServicesUtils(
    name: 'Web Development',
    icon: 'assets/icons/flutter.svg',
    description:
        "Implemented responsive design principles to provide a seamless user experience on both desktop and mobile browsers.",
    tool: ['Flutter', 'HTML, css'],
  ),
  ServicesUtils(
    name: 'API Development',
    icon: 'assets/icons/golang.svg',
    description:
        "Implemented responsive design principles to provide a seamless user experience on both desktop and mobile browsers.",
    tool: ['Golang', 'Python'],
  ),
  ServicesUtils(
    name: 'AI/ML Applications',
    icon: 'assets/icons/tensorflow.svg',
    description:
        "Developed machine learning models for various applications including image classification, keyword extraction, speech recognition, and more.",
    tool: ['Python', 'Tensorflow', 'Keras', 'Scikit-learn', 'Pandas', 'Numpy'],
  ),
  ServicesUtils(
    name: 'Containerization',
    icon: 'assets/icons/docker.svg',
    description:
        "Utilized Docker to containerize applications and manage them in isolated environments.",
    tool: ['Docker', 'Kubernetes'],
  ),
  ServicesUtils(
    name: 'Database Management',
    icon: 'assets/icons/firebase.svg',
    description:
        "Utilized Docker to containerize applications and manage them in isolated environments.",
    tool: [
      'Firebase',
      'PostgreSQL',
      'Sqlite',
      'Apache Airflow',
      'Apache Spark'
    ],
  ),
];
