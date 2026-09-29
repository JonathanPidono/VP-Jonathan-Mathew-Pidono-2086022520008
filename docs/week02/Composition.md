# Week 02 — Composition Rationale (TCG Vault)

## VaultSummary

- Trigger: Readability, karena widget ini memisahkan tampilan ringkasan (jumlah kartu dan total nilai koleksi) dari method `build()` di screen agar tidak terlalu panjang dan lebih mudah dibaca.
- Owns: Tidak memiliki state apapun (stateless). Hanya menerima `totalCards` dan `totalValue` dari parent untuk ditampilkan.
- Reports upward: Tidak ada, karena hanya menampilkan teks dan tidak memiliki callback.

## VaultSearchField

- Trigger: Readability, karena widget ini memisahkan `TextField` beserta dekorasinya (hint, ikon search, border) dari `build()` di screen.
- Owns: Tidak memiliki state apapun (stateless). Teks pencarian tidak disimpan di widget ini, melainkan di `_query` milik parent.
- Reports upward: Memanggil `onChanged(String value)` setiap kali user mengetik, lalu screen memperbarui `_query` dan daftar kartu difilter ulang.

## BrandFilterBar

- Trigger: Readability, karena widget ini memisahkan logic pembuatan chip filter (All, Pokémon, Yu-Gi-Oh!, Magic) dari `build()` di screen agar tidak terlalu panjang.
- Owns: Tidak memiliki state apapun (stateless). Hanya menerima `selected` dari parent untuk menentukan chip mana yang sedang aktif.
- Reports upward: Memanggil `onSelected(String? brand)` setiap kali user memilih chip yang berbeda. Nilai `null` berarti chip "All".

## CardTile

- Trigger: Reuse, karena widget ini dipakai berulang kali di dalam `GridView.builder`, satu instance untuk setiap kartu yang lolos filter dan search. Jika ada 6 kartu yang tampil, `CardTile` dibuat 6 kali.
- Owns: Tidak memiliki state apapun (stateless). Hanya menerima satu objek `TcgCard` untuk ditampilkan. Status favorit dibaca dari `card.isFavorite`, bukan disimpan di dalam widget.
- Reports upward: Memanggil `onToggleFavorite()` saat tombol bintang ditekan. Screen lalu mengubah data kartu tersebut dan grid dibangun ulang.

## VaultEmptyState

- Trigger: Reuse dan readability, karena widget ini dipakai untuk dua kondisi (vault benar-benar kosong, atau hasil search/filter tidak ditemukan) dan memisahkan logic tampilan kosong dari logic grid di `build()`.
- Owns: Tidak memiliki state apapun (stateless). Hanya menerima `query` untuk menentukan pesan yang ditampilkan.
- Reports upward: Memanggil `onClear()` saat tombol "Clear filters" ditekan, lalu screen mengosongkan `_query` dan `_brand`.

## Ringkasan 

Semua state yang dapat berubah, yaitu `_cards`, `_loading`, `_query`, dan `_brand`, disimpan secara terpusat di `_VaultScreenState`. Kelima widget di atas bersifat `StatelessWidget` dan tidak memiliki state sendiri. Mereka hanya menerima data melalui constructor dan melaporkan interaksi user ke parent melalui callback (`onChanged`, `onSelected`, `onToggleFavorite`, `onClear`).