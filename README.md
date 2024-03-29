

# ยินดีตอนรับสู่ 4Kings Sorting Hat #

<details>
  <summary><strong>ขั้นตอนการติดตั้ง</strong></summary>
</details>

- Install the Flutter SDK [Flutter SDK](https://docs.flutter.dev/get-started/install?gad_source=1&gclid=Cj0KCQjwhtWvBhD9ARIsAOP0GogcIUJGwVoTIPL7Ad6Xa_6qm17uYMxnl_B6hxnsKheH4u2KfqYHrL8aAs0aEALw_wcB&gclsrc=aw.ds)   ❗❗ ห้าม Install ใน C:\Program Files ❗❗
- Update Path ใน Environment Variables ตัวอย่างเช่น C:\src\flutter\bin
- Verify Flutter Installation เปิด Command Prompt และพิมพ์ flutter doctor เพื่อตรวจสอบว่า Flutter ถูกติดตั้งแบบถูกต้อง
- ถ้ายังไม่มี  Visual Studio Code สามารถ Download ได้ตรงนี้ [Visual Studio Code](https://code.visualstudio.com/download)
- Download Dart extension ใน Visual Studio Code
- Download Files จาก GitHub หรือ clone จาก Git https://github.com/PHAWAPHON/sortinghat2.git
- [ดูวิธีเพิ่มเติม](https://docs.flutter.dev/get-started/install/windows/desktop)
 <br>

  `เปิด Command Promt ใช้คำสั่ง cd เลือก file path ที่คุณเก็บอยากเก็บ`
  
   ```bash
   cd path\to\your\files
   ```
   <br>
   
   `git clone`
  
  ```bash
  git clone https://github.com/PHAWAPHON/sortinghat2.git
   ```
<br>

-  เปิด Folder ใน Visual Studio Code แล้วค้นหา file ที่ชื่อว่า main.dart กด Start Debugging

<br>
<details>
  <summary><strong>แต่ถ้าคุณไม่อยากเสียเวลาไปลงProject เราก็มีทางเลือกในการ Run App ที่ deploy ไปยัง Vercel</strong></summary>
</details> 


  ✔️✔️ https://sortinghat2.vercel.app/ ✔️✔️

<br>
<details>
  <summary><strong>วิธีการใช้งาน</strong></summary>
</details
  
- ใส่เลขจำนวนนักเรียน
- ใส่ชื่อแล้วกดปุ่ม Enter หรือ มีปุ่ม Reset เพื่อลบชื่อนักเรียนทั้งหมด
- ระบบจะทำการสุ่มโรงเรียนแล้วPopup ว่าได้โรงเรียนไหน
- มี Card ของแต่ละโรงเรียน Card สามารถเลื่อนซ้ายขวาได้ ถ้ากดที่ Card จะมีปุ่มให้กดเข้าไปแล้วจะแสดงรายชื่อนักเรียนของแต่ละโรงเรียน
