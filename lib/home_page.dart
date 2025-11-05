import 'package:flutter/material.dart';

// Catatan Penting:
// Pastikan Anda telah memiliki folder 'assets/images/' dan semua file gambar yang dibutuhkan!

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? _selectedCategory;

  // Fungsi untuk membangun halaman utama
  Widget _buildPage(int index) {
    if (index == 0) {
      return BerandaLandscapeContent(
        selectedCategory: _selectedCategory,
        onCategorySelected: _updateSelectedCategory,
      );
    }
    
    // Halaman lain (placeholder)
    switch (index) {
      case 1:
        return const Center(child: Text('Halaman Notifikasi', style: TextStyle(fontSize: 24)));
      case 2:
        return const Center(child: Text('Halaman Chat', style: TextStyle(fontSize: 24)));
      case 3:
        return const Center(child: Text('Halaman Profil', style: TextStyle(fontSize: 24)));
      default:
        return const Center(child: Text('Error', style: TextStyle(fontSize: 24)));
    }
  }

  // Fungsi untuk memperbarui kategori yang dipilih dan memicu rebuild
  void _updateSelectedCategory(String category) {
    setState(() {
      if (_selectedCategory == category) {
        _selectedCategory = null; 
      } else {
        _selectedCategory = category;
      }
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Menu Navigasi Samping (NavigationRail)
          NavigationRail(
            backgroundColor: Colors.white,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                if (index != 0) {
                  _selectedCategory = null;
                }
              });
            },
            labelType: NavigationRailLabelType.selected,
            leading: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 2,
              child: const Icon(Icons.add, color: Colors.white),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.notifications_outlined),
                selectedIcon: Icon(Icons.notifications),
                label: Text('Notifikasi'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: Text('Chat'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: Text('Profil'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Konten Halaman Utama
          Expanded(
            child: _buildPage(_selectedIndex),
          ),
        ],
      ),
    );
  }
}

// Widget khusus untuk konten beranda dalam mode landscape
class BerandaLandscapeContent extends StatelessWidget {
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const BerandaLandscapeContent({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildDonationBanner(context),
            const SizedBox(height: 24),

            // 4. Kategori
            _buildCategories(context),
            const SizedBox(height: 24),

            // 5. Daftar Hewan (Grid)
            Text(
              selectedCategory != null ? "Hewan Kategori $selectedCategory" : "Adopsi Terdekat",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildPetGrid(context, selectedCategory), 
          ],
        ),
      ),
    );
  }

  // --- Widget & Fungsi Pendukung ---
  
  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello,", style: TextStyle(fontSize: 20, color: Colors.grey)),
            Text("Klinik Kasih Anabul", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/images/profile1.png'),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search pets...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDonationBanner(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.purple[100]?.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Street pets need\nour protection",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple[900],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[800],
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Donate Now"),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/banner_dog.png',
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {"icon": Icons.pets, "label": "Cats"}, 
      {"icon": Icons.cruelty_free, "label": "Dogs"}, 
      {"icon": Icons.stream, "label": "Fish"}, 
      {"icon": Icons.bug_report, "label": "Birds"}, 
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextButton(
              onPressed: () {
                onCategorySelected(""); 
              },
              child: const Text("Explore"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category["label"];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: GestureDetector(
                  onTap: () {
                    onCategorySelected(category["label"] as String);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue[100] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category["icon"] as IconData,
                          size: 30,
                          color: isSelected ? Colors.blue[800] : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category["label"] as String,
                        style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected ? Colors.blue[800] : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showPetDetailDialog(BuildContext context, Map<String, dynamic> petData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            "Detail ${petData["name"]}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    petData["image"] as String,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                _buildDetailRow("Nama:", petData["name"] as String, Icons.tag),
                _buildDetailRow("Jarak:", petData["distance"] as String, Icons.location_on_outlined),
                _buildDetailRow("Jenis Kelamin:", petData["gender"] as String,
                    petData["gender"] == "Jantan" ? Icons.male : Icons.female),
                _buildDetailRow("Usia:", petData["age"] as String, Icons.cake_outlined),
                const SizedBox(height: 10),
                Text("Keterangan Tambahan:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[700])),
                const SizedBox(height: 5),
                Text(
                  petData["description"] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Tutup')),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Proses adopsi ${petData["name"]} dimulai!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Adopsi Sekarang'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 10),
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  // --- Widget Grid Hewan dengan Filtering ---

  Widget _buildPetGrid(BuildContext context, String? selectedCategory) {
    // Data hewan (pastikan path gambar sesuai dengan nama file Anda)
    final allPets = [
      {
        "image": "assets/images/kucing.jpg",
        "name": "Kucing Persia", 
        "distance": "1.5 Km Away",
        "gender": "Jantan",
        "age": "2 Tahun",
        "description": "Kucing Persia yang manja, bulu tebal warna abu-abu. Sudah divaksinasi lengkap.",
        "category": "Cats"
      },
       {
        "image": "assets/images/kucinganggora.jpg",
        "name": "Kucing Persia", 
        "distance": "1.5 Km Away",
        "gender": "Jantan",
        "age": "2 Tahun",
        "description": "Kucing Persia yang manja, bulu tebal warna abu-abu. Sudah divaksinasi lengkap.",
        "category": "Cats"
      },
      {
        "image": "assets/images/Kelinci.jpg",
        "name": "Kelinci Lop",
        "distance": "1.2 Km Away",
        "gender": "Betina",
        "age": "1 Tahun",
        "description": "Kelinci lincah, berbulu putih bersih, sangat aktif, dan suka makan wortel.",
        "category": "Cats"
      },
      {
        "image": "assets/images/kuda.jpg",
        "name": "Kuda Poni",
        "distance": "2.1 Km Away",
        "gender": "Jantan",
        "age": "5 Tahun",
        "description": "Kuda poni kecil, sangat ramah pada anak-anak. Jinak dan mudah dilatih.",
        "category": "Dogs"
      },
      {
        "image": "assets/images/kudajantan.jpg",
        "name": "Kuda Poni",
        "distance": "2.1 Km Away",
        "gender": "Jantan",
        "age": "5 Tahun",
        "description": "Kuda poni kecil, sangat ramah pada anak-anak. Jinak dan mudah dilatih.",
        "category": "Dogs"
      },
      {
        "image": "assets/images/sapi.jpg",
        "name": "Sapi Holstein",
        "distance": "2.0 Km Away",
        "gender": "Betina",
        "age": "3 Tahun",
        "description": "Sapi perah sehat jenis Holstein, produksi susu bagus.",
        "category": "Dogs"
      },
      {
        "image": "assets/images/ikan.jpg",
        "name": "Ikan Cupang", 
        "distance": "0.5 Km Away",
        "gender": "Jantan",
        "age": "6 Bulan",
        "description": "Ikan hias air tawar, berwarna cerah dan agresif.",
        "category": "Fish"
      },
      {
        "image": "assets/images/ikan.png",
        "name": "Ikan Cupang", 
        "distance": "0.5 Km Away",
        "gender": "Jantan",
        "age": "6 Bulan",
        "description": "Ikan hias air tawar, berwarna cerah dan agresif.",
        "category": "Fish"
      },
      {
        "image": "assets/images/burung.jpg",
        "name": "Burung Kenari", 
        "distance": "0.8 Km Away",
        "gender": "Betina",
        "age": "1.5 Tahun",
        "description": "Burung kicau, suaranya merdu, cocok untuk peliharaan.",
        "category": "Birds"
      },
      {
        "image": "assets/images/burungmurai.jpg",
        "name": "Burung Kenari", 
        "distance": "0.8 Km Away",
        "gender": "Betina",
        "age": "1.5 Tahun",
        "description": "Burung kicau, suaranya merdu, cocok untuk peliharaan.",
        "category": "Birds"
      },
    ];

    // Lakukan Filtering
    final filteredPets = allPets.where((pet) {
      if (selectedCategory == null) {
        return true; 
      }
      return pet["category"] == selectedCategory;
    }).toList();

    // Tampilkan pesan jika tidak ada hasil
    if (filteredPets.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            "Tidak ada hewan untuk kategori ${selectedCategory ?? ''} saat ini.",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      );
    }
    
    // Tampilkan GridView dari filteredPets
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredPets.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        final pet = filteredPets[index];
        return InkWell(
          onTap: () {
            _showPetDetailDialog(context, pet);
          },
          borderRadius: BorderRadius.circular(16),
          // Menonaktifkan highlight dan splash effect
          highlightColor: Colors.transparent, 
          splashColor: Colors.transparent,     
          child: Card(
            elevation: 2,
            shadowColor: Colors.grey.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.asset(
                      pet["image"] as String,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            pet["name"] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.favorite_border, color: Colors.red[300]),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        pet["distance"] as String,
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}