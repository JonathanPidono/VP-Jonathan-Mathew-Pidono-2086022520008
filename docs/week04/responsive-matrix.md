# Minggu 4 — H1 Matriks responsif

### Tes 1 HP kecil (320 dp)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | pass | Spinner di tengah; tidak ada yang bisa overflow. |  |
| Populated (grid) | fail | Tata letak compact, 2 kolom dengan lebar sekitar 138 dp. Nama kartu 2 baris lalu titik-titik. Harga ada di `Expanded` + `FittedBox(scaleDown)`, jadi mengecil di sebelah tombol bintang. | Diperbaiki: `Row` harga + bintang lebih lebar daripada kartu 138 dp (sisa sekitar 114 dp setelah padding). |
| Empty: vault tanpa kartu | pass | Ikon, judul, pesan, dan tombol tersusun satu kolom di tengah dalam scroll view. |  |
| Empty: filter tidak cocok | pass | Sama dengan baris sebelumnya. Kata pencarian di judul dibatasi 3 baris. |  |

### Tes 2 HP besar (430 dp)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | pass | Spinner di tengah. |  |
| Populated (grid) | pass | Tata letak compact, 2 kolom dengan lebar sekitar 193 dp. | Tidak perlu perubahan. |
| Empty: vault tanpa kartu | pass | Satu kolom di tengah. |  |
| Empty: filter tidak cocok | pass | Satu kolom di tengah. |  |

### Tes 3 Tablet (800 dp)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | pass | Spinner di tengah. |  |
| Populated (grid) | fail | Tata letak wide (>= 600 dp): kontrol pindah ke panel samping 320 dp dan grid punya scroll sendiri, 2 kolom di portrait 800 dp dan 4 kolom di landscape 1280 dp. Strukturnya berubah, bukan sekadar melebar. | Diperbaiki: grid 2 kolom tetap yang lama hanya melebar sehingga kartu menjadi sangat besar. |
| Empty: vault tanpa kartu | pass | Empty state di tengah area grid; panel samping tetap terlihat. |  |
| Empty: filter tidak cocok | pass | Sama dengan baris sebelumnya. |  |

### Tes 4 Landscape (semua ukuran di atas)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | pass | Spinner di tengah. |  |
| Populated (grid) | fail | 568x320 memakai tata letak compact: kontrol dan grid berbagi SATU scroll view, jadi tidak ada header dengan tinggi tetap. 932x430 dan lebih lebar memakai tata letak wide dengan panel samping berupa `ListView`. | Diperbaiki: `Column` lama menyisakan sekitar 250 dp untuk kontrol dengan ukuran tetap, sehingga layar setinggi 320 dp overflow. |
| Empty: vault tanpa kartu | pass | `SliverFillRemaining(hasScrollBody: false)` membuat empty state bisa di-scroll kalau lebih tinggi dari sisa ruang. |  |
| Empty: filter tidak cocok | pass | Sama dengan baris sebelumnya. |  |

### Tes 5 Teks panjang (200 karakter)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | n/a | Tidak berlaku. |  |
| Populated (grid) | fail | Nama: `maxLines: 2` + titik-titik (nama 200 karakter yang bisa dipecah spasi dan yang tanpa spasi, brand dan rarity panjang, `Rp150000000`). Teks ringkasan: `maxLines: 1` + titik-titik. Total nilai: `FittedBox`. | Diperbaiki: teks ringkasan dan judul empty state tadinya tidak punya `maxLines`. Jalankan dengan `DATA=long`. |
| Empty: vault tanpa kartu | n/a | n/a |  |
| Empty: filter tidak cocok | pass | Judul: `maxLines: 3` + titik-titik, untuk kata pencarian yang sangat panjang. |  |

### Tes 6 Empty state

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | n/a | Tidak berlaku. |  |
| Populated (grid) | n/a | n/a |  |
| Empty: vault tanpa kartu | fail | Ikon + 'Your vault is empty' + aksi 'Reload'. Jalankan dengan `DATA=empty`. | Diperbaiki: dua keadaan tadinya memakai satu pesan ('No cards here') dan tombol 'Clear filters' yang tidak berguna saat vault kosong. Sekarang ada dua varian. 'Reload' menjalankan ulang pemuatan data; aplikasi belum punya fitur tambah kartu. |
| Empty: filter tidak cocok | pass | Ikon + 'No results for ...' + aksi 'Clear filters'. Cari kata `zzz`. |  |

### Tes 7 Daftar panjang (500 item)

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | n/a | Tidak berlaku. |  |
| Populated (grid) | pass | `SliverGrid.builder` hanya membangun tile yang terlihat. Tidak ada `shrinkWrap` di kode. Jalankan dengan `DATA=big`. | Tanpa `shrinkWrap`: sudah dicek dengan pencarian teks di kode. |
| Empty: vault tanpa kartu | n/a | n/a |  |
| Empty: filter tidak cocok | pass | Cari 'Card #4' di `DATA=big` untuk menyaring 500 kartu. |  |

### Tes 8 Keyboard

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | n/a | Tidak berlaku. |  |
| Populated (grid) | fail | Kolom pencarian ada di dalam scroll view dan `Scaffold` mengecilkan body saat keyboard muncul, jadi Flutter menggulir kolom yang sedang fokus ke area terlihat. Kasus yang paling sempit adalah landscape + keyboard di HP kecil (sisa tinggi body sekitar 84 dp). | Diperbaiki: header dengan tinggi tetap yang lama tidak bisa digulir menjauh dari keyboard. Cek dulu kasus landscape + keyboard. |
| Empty: vault tanpa kartu | pass | Kolom pencarian ada di atas empty state dalam scroll view yang sama. |  |
| Empty: filter tidak cocok | pass | Sama dengan baris sebelumnya. |  |

### Tes 9 Mode gelap

| Layar | Hasil | Expected (dari membaca kode) | Perbaikan / catatan |
|---|:-:|---|---|
| Loading | pass | Spinner memakai warna tema. |  |
| Populated (grid) | pass | Semua warna berasal dari peran `ColorScheme`; tidak ada warna yang ditulis langsung. Jalankan dengan `THEME=dark`. | Tidak perlu perubahan. |
| Empty: vault tanpa kartu | pass | Ikon, judul, dan pesan memakai `onSurfaceVariant` dan `onSurface`. |  |
| Empty: filter tidak cocok | pass | Sama dengan baris sebelumnya. |  |

## Perbaikan yang dibuat

Semua ini ditemukan dengan membaca kode asli dan menghitung ukuran, bukan dengan menjalankannya.

1. **Baris harga overflow di 320 dp.** Kartu 2 kolom lebarnya sekitar 138 dp; setelah padding tersisa sekitar 114 dp untuk teks harga dan tombol bintang 48 dp. Harga seperti `Rp1200000` butuh lebih dari itu, jadi akan overflow. Diperbaiki dengan `Expanded` + `FittedBox(scaleDown)`.
2. **Header dengan tinggi tetap.** Ringkasan, pencarian, dan filter berada di `Column` di atas grid `Expanded`, jadi landscape atau keyboard terbuka di layar pendek akan overflow. Sekarang header ikut digulir bersama grid.
3. **Grid hanya melebar di tablet.** `crossAxisCount: 2` yang tetap membuat kartu sangat besar. Sekarang jumlah kolom dihitung dari `maxCrossAxisExtent`, dan mulai 600 dp strukturnya berubah menjadi panel samping + grid.
4. **Teks tanpa batas.** Nama kartu (sekarang 2 baris), teks ringkasan, dan judul empty state diberi `maxLines` dan titik-titik.
5. **Satu empty state untuk dua keadaan.** Sekarang vault kosong ('Reload') dan hasil pencarian kosong ('Clear filters') punya ikon, pesan, dan aksi masing-masing.
6. **Data uji dan pengaturan.** Pengaturan `--dart-define` `DATA` dan `THEME` serta data uji (nama 200 karakter, tanpa item, 500 item) ditambahkan supaya daftar tes bisa dijalankan tanpa mengubah kode.