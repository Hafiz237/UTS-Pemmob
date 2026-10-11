import '../models/question.dart';

const List<Question> dummyQuestions = [
  Question(
    category: 'Organisasi arsitektur komputer',
    text: 'Apa kepanjangan dari CPU?',
    options: [
      'Central Process Unit',
      'Central Processing Unit',
      'Computer Personal Unit',
      'Control Processing Utility',
    ],
    correctIndex: 1,
    explanation:
    'CPU (Central Processing Unit) adalah otak komputer yang menjalankan instruksi program.',
  ),
  Question(
    category: 'Dasar pemrograman',
    text: 'Bilangan biner 1010 sama dengan bilangan desimal berapa?',
    options: ['8', '10', '12', '14'],
    correctIndex: 1,
    explanation: '1010 = (1×8) + (0×4) + (1×2) + (0×1) = 10.',
  ),
  Question(
    category: 'STRUKTUR DATA',
    text: 'Struktur data yang menerapkan prinsip LIFO (Last In, First Out) adalah...',
    options: ['Queue', 'Array', 'Stack', 'Linked List'],
    correctIndex: 2,
    explanation:
    'Stack seperti tumpukan piring: elemen terakhir yang masuk adalah yang pertama keluar.',
  ),
  Question(
    category: 'WEB',
    text: 'HTML adalah singkatan dari...',
    options: [
      'HyperText Markup Language',
      'HighText Machine Language',
      'HyperTool Multi Language',
      'HyperText Making Logic',
    ],
    correctIndex: 0,
    explanation:
    'HTML adalah bahasa markup untuk menyusun struktur halaman web.',
  ),
  Question(
    category: 'ALGORITMA',
    text: 'Berapa kompleksitas waktu algoritma Binary Search?',
    options: ['O(n)', 'O(n²)', 'O(1)', 'O(log n)'],
    correctIndex: 3,
    explanation:
    'Binary Search membagi dua ruang pencarian di setiap langkah, sehingga O(log n). Syaratnya data harus terurut.',
  ),
  Question(
    category: 'KEAMANAN',
    text: 'Protokol yang mengenkripsi komunikasi antara browser dan website adalah...',
    options: ['HTTP', 'FTP', 'HTTPS', 'SMTP'],
    correctIndex: 2,
    explanation:
    'HTTPS = HTTP + TLS/SSL, sehingga data yang dikirim terenkripsi.',
  ),
  Question(
    category: 'HARDWARE',
    text: 'Memori yang isinya hilang saat komputer dimatikan disebut...',
    options: ['Volatile', 'Non-volatile', 'Permanent', 'Cache disk'],
    correctIndex: 0,
    explanation:
    'RAM bersifat volatile: butuh listrik untuk menyimpan data, berbeda dengan SSD/HDD.',
  ),
  Question(
    category: 'PEMROGRAMAN',
    text: 'Bahasa pemrograman yang dipakai Flutter untuk membangun aplikasi adalah...',
    options: ['Kotlin', 'Dart', 'Swift', 'Java'],
    correctIndex: 1,
    explanation: 'Flutter dibuat dengan Dart, bahasa yang dikembangkan Google.',
  ),
  Question(
    category: 'BASIS DATA',
    text: 'Perintah SQL untuk mengambil data dari tabel adalah...',
    options: ['INSERT', 'UPDATE', 'DELETE', 'SELECT'],
    correctIndex: 3,
    explanation:
    'SELECT dipakai untuk membaca data, contoh: SELECT * FROM mahasiswa;',
  ),
  Question(
    category: 'JARINGAN',
    text: 'Jaringan komputer yang mencakup area terbatas seperti satu gedung disebut...',
    options: ['WAN', 'LAN', 'MAN', 'VPN'],
    correctIndex: 1,
    explanation:
    'LAN (Local Area Network) menghubungkan perangkat dalam area kecil, misalnya rumah atau kantor.',
  ),
];