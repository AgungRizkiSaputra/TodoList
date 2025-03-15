# Praktikum 1

### GIF
<img src="https://github.com/AgungRizkiSaputra/TodoList/blob/main/images/GIF_Praktikum1.gif"  width="300px">

## data_layer.dart
    export 'plan.dart';
    export 'task.dart';

### Penjelasan
Dapat membungkus beberapa data ke dalam sebuah file yang akan mengekspor kedua model tersebut sehingga bisa di import sekaligus dari 1 file.

## Variabel Plan
    Plan plan = const Plan();

### Penjelasan
Variabel plan di gunakan untuk menyimpan data. Kenapa di buat konstanta? karna untuk inisialisasi awal dengan nilai plan tetap bisa di perbarui selama apknya masih berjalan.

## setState()

### Penjelasan
- Menampilkan input teks dengan nilai task.deskription saat mengetik atau mengubah teksnya itu dapat di perbarui dengan setState().
- Mengelola daftar tugas dalam aplikasi yang dapat menandai tugas selesai/tidak dengan menggunakan checkbox.

## initState() dan dispose()
    @override
    void initState() {
      super.initState();
      scrollController = ScrollController()
        ..addListener(() {
          FocusScope.of(context).requestFocus(FocusNode());
        });
    }

    @override
    void dispose() {
      scrollController.dispose();
      super.dispose();
    }


### Penjelasan
- Method initState(), Dipanggil sekali saat state pertama kali dibuat dan digunakan untuk inisialisasi variabel atau objek yang hanya di buat sekali.
- Method dispose(), Dipanggil saat state dihapus dari widget tree dan di gunakan untuk membersihkan resource agar tidak terjadi memory leak

# Praktikum 2

### GIF
<img src="https://github.com/AgungRizkiSaputra/TodoList/blob/main/images/GIF_Praktikum2.gif"  width="300px">

## InheritedWidget dan InheritedNotifier

### Penjelasan
InheritedWidget harus memanggil setState() untuk memperbarui nilai yang dimana harus menyalin dan meneruskan nilai baru secara manual. Sedangkan InheritedNotifier Menggunakan ValueNotifier, karna lebih efisien yang secara otomatis rebuild jika ValueNotifier berubah.

## Method plan.dart
    int get completedCount => tasks
      .where((task) => task.complete)
      .length;
    
    String get completenessMessage =>
      '$completedCount out of ${tasks.length} tasks';

### Penjelasan
Method completedCount, menghitung jumlah tugas dalam daftar task yang sudah di tandai sebagai selesai secara efisien.
Method completenessMessage, Menghasilkan pesan status kemajuan tugas dalam format string, UI bisa langsung mengambil status tugas tanpa harus memproses ulang data.

## Menambahkan widget SafeArea
    @override
    Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: const Text('Master Plan')),
         body: ValueListenableBuilder<Plan>(
           valueListenable: PlanProvider.of(context),
           builder: (context, plan, child) {
             return Column(
               children: [
                 Expanded(child: _buildList(plan)),
                 SafeArea(child: Text(plan.completenessMessage))
               ],
             );
           },
         ),
         floatingActionButton: _buildAddTaskButton(context),
       );
    }

### Penjelasan
Menggunakan state management dengan ValueListenableBuilder dan InheritedNotifier. Struktur utama dari kode ini menggunakan Scaffold,
untuk menampilkan daftar tugas beserta status penyelesaiannya, dan Floating Action Button untuk menambahkan tugas baru. serta status penyelesaian tugas yang ditampilkan dalam teks menggunakan plan.completenessMessage

# Praktikum 3

### GIF
<img src="https://github.com/AgungRizkiSaputra/TodoList/blob/main/images/GIF_Praktikum3.gif"  width="300px">

## Menggambarkan Struktur Widget
Menggambarkan perubahan struktur widget dalam aplikasi Flutter setelah dilakukan navigasi menggunakan Navigator.push.

## Penjelasan
- Sebelum:
  - MaterialApp adalah root dari aplikasi
  - PlanProvider, yang menyediakan data ke PlanCreatorScreen.
  - PlanCreatorScreen:
    - Column: berisi TextField untuk input
    - Expanded → ListView (daftar item yang dapat diperluas)
- Setelah:
  - Scaffold sebagai struktur dasar layar
  - Column:
    - Expanded → ListView (menampilkan daftar rencana)
    - SafeArea → Text (menampilkan informasi tambahan, terhindar dari notch/status bar)
