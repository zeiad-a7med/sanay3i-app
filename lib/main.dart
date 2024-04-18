import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
late Database mydb;

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  mydb= await openDatabase(
      "sanayee.db",
      version:1,
      onCreate: (db,version)=>_createDb(db)

  );
  runApp(MyApp());
}

 void _createDb(Database db){
   db.execute('CREATE TABLE services(category VARCHAR(70),service VARCHAR(150),img VARCHAR(5000));');

   db.execute('INSERT INTO services VALUES("Emergency", "Electricity", "https://tse2.mm.bing.net/th?id=OIP.hdTziu8ho03HXg9Y5sAO4QHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Emergency", "Plumbing", "https://tse1.mm.bing.net/th?id=OIP.QuVqlcXc3fR5EhRQvoNeSwHaGq&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Emergency", "Carpentry", "https://tse1.mm.bing.net/th?id=OIP.DgOrMZoRUA5YY3z5k0uC9AHaE8&pid=Api&P=0");');

   db.execute('INSERT INTO services VALUES("AC", "wash with installation", "https://tse2.mm.bing.net/th?id=OIP.-rF2QPHh-ukQVISBWoCxFQHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("AC", "wash without removal", "https://tse2.mm.bing.net/th?id=OIP.yReXkwGyZ-3-9GOPxdXmeAHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("AC", "Clean pipe & filters", "https://tse3.mm.bing.net/th?id=OIP.8b6dCeFaF7ygxTcMa0jz4AHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("AC", "installation indoor", "https://tse4.mm.bing.net/th?id=OIP.GGo80Wrn9kARjZpQ5w-X-QHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("AC", "outdoor unit", "https://tse4.mm.bing.net/th?id=OIP.GGo80Wrn9kARjZpQ5w-X-QHaE8&pid=Api&P=0");');


   db.execute('INSERT INTO services VALUES("Cleaning", "General cleaning", "https://tse3.mm.bing.net/th?id=OIP.lNUefsqzaJlozcTkAeVoVQHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Cleaning", "Steam furniture cleaning", "https://tse4.mm.bing.net/th?id=OIP.aAVknwSE2UZHtU7CtaMz9QHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Cleaning", "Clean your upper water tank", "https://tse1.mm.bing.net/th?id=OIP.P56DpkwH5_azDi-8PHV8mAHaDS&pid=Api&P=0");');

   db.execute('INSERT INTO services VALUES("Electricity", "Spot light installation", "https://tse4.explicit.bing.net/th?id=OIP.fz0W-Giu5gpqZPHfMUf4CwHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Electricity", "installation a chandelier", "https://tse1.mm.bing.net/th?id=OIP.WKCT8PuxNWBvQvrhAly7MgHaD4&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Electricity", "distribution panel", "https://tse3.mm.bing.net/th?id=OIP.RjGEzOOVfYKCeM8tLnUJ_wHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Electricity", "ventilation fan installation", "https://tse2.mm.bing.net/th?id=OIP.R7wWuqCxo7ZfkXX8JLDfqgHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Electricity", "switch installation", "https://tse4.mm.bing.net/th?id=OIP.Xn-42jM3ZSIsytqiHu6uhgHaEc&pid=Api&P=0");');

   db.execute('INSERT INTO services VALUES("Appliances", "washing Machine", "https://tse1.mm.bing.net/th?id=OIP.Xn-_WsKur1YVV-ukZvwFfgHaEq&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Appliances", "Refrigerator", "https://tse1.mm.bing.net/th?id=OIP.I3aqt33I4Tbtas-xPsG4_gHaE6&pid=Api&P=0");');


   db.execute('INSERT INTO services VALUES("Plumbing", "Change flush", "https://tse3.mm.bing.net/th?id=OIP.d70czO1clv4hJfJktzLHsgHaFC&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Plumbing", "Motor installation", "https://tse2.mm.bing.net/th?id=OIP.wEE6rBAemTxuFE-PqLK2swHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Plumbing", "Filter installation", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5KuaH9qRAStx8Yt8YlOfffYweIYGCPJXB_g&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Plumbing", "Leaking", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmsn-V0O7LCi7He4c3lQTyAjbmjJXjgjpy2w&usqp=CAUv");');
   db.execute('INSERT INTO services VALUES("Plumbing", "Automatic pump change", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQm684YSIe4KIBZhfebCOP2XP11l1-gwQKeFQ&usqp=CAU");');


   db.execute('INSERT INTO services VALUES("Networks", "Camera intstallation", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKEak_QsB38v-jLh04CNNCeFcFsH9P-INaRQ&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Networks", "General maintenance", "https://tse3.mm.bing.net/th?id=OIP.VISJ_wjXa43Wu8Pqs4J9dAHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Networks", "Internet booster", "https://tse2.mm.bing.net/th?id=OIP.TNSz6nc8hYUk5_HEgGvdhwHaFO&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Networks", "Programming", "https://tse4.mm.bing.net/th?id=OIP.qVk6ab5XhEMa5aIe14zfTgHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Networks", "Establishing network", "https://tse1.mm.bing.net/th?id=OIP.vaZH9ZxOzY0W2Q97aeyJLAHaE8&pid=Api&P=0");');

   db.execute('INSERT INTO services VALUES("Grass", "Installation", "https://tse2.mm.bing.net/th?id=OIP.Fxx-KZfheWHqBJZOcaAL7gHaEH&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Grass", "Lawn repair", "https://tse4.mm.bing.net/th?id=OIP.-osPKd4Ft_vUZ524Ewrd2gHaFj&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Grass", "Maintenance", "https://tse1.mm.bing.net/th?id=OIP.Zl7HJhcHdCzVEk-LIbWU0wHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Grass", "seeding", "https://tse2.mm.bing.net/th?id=OIP.OA6wKNHnhUq_kXZzgEwpfAHaEK&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Grass", "cutting", "https://tse4.mm.bing.net/th?id=OIP.pwjf0sBX4uS043NyTEnW-wHaEq&pid=Api&P=0");');

   db.execute('INSERT INTO services VALUES("Carpentry", "Curtain installation", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyLX5lYZ_sci9lx76eYUsAQMpBSWfjvr3gpQ&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Carpentry", "Door repair", "https://tse1.mm.bing.net/th?id=OIP.C64yzrq4OgUdkK7w4zJmkQHaEc&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Carpentry", "Door installation", "https://tse4.mm.bing.net/th?id=OIP.FXxdSgDCOS4cOTS4xEfTpgHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Carpentry", "Bed installation", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcStac1G8KYwNovFVD8BXyhcNxdS97v4HVe1GA&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Carpentry", "Dresser installation", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1w-IUgFWiyH1zFGqAis8MLMwxerfJbUwsEQ&usqp=CAU");');

   db.execute('INSERT INTO services VALUES("Painting", "Internal paint", "https://tse2.mm.bing.net/th?id=OIP.gl11XGap-pjptNRjBQcmEQHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Painting", "External paint", "https://tse3.mm.bing.net/th?id=OIP.LDjdE9-wNa-N8jeLGhwM6gHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Painting", "Wallpaper", "https://tse1.mm.bing.net/th?id=OIP.NjaOhUJPX2yK1fZw0BXdggHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Painting", "Dry wall", "https://tse3.mm.bing.net/th?id=OIP.BgLBj8ski1QqlW3HC09MmgHaDA&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Painting", "Cracked painting", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdxE3O2XG5Xq3aXcR0BWzXChk7KMKkYl9_pg&usqp=CAU");');

   db.execute('INSERT INTO services VALUES("Flooring", "Tiles installation", "https://tse4.explicit.bing.net/th?id=OIP.7gpqenXfhXtkmAgnzDEofAHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Flooring", "Clean tile", "https://tse3.mm.bing.net/th?id=OIP.qyl6m3oCkC04xa_6B7TFtwHaHa&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Flooring", "Marble Plush", "https://tse3.mm.bing.net/th?id=OIP.DNOc6Z1rxtseCex9CFqzGgHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Flooring", "Dismantling", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCYgFdgRULYcM4O86XcBO2wP5QkfAaihPjhQ&usqp=CAU");');

   db.execute('INSERT INTO services VALUES("Pest Control", "Studio", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRg55abON-YzZqi0jGOvQmLiMDP1haTefAe8Q&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Pest Control", "Garden sprinkler", "https://tse3.mm.bing.net/th?id=OIP.zTv-St2ddOkNgh1kGVZpqAHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Pest Control", "One bedroom", "https://tse1.mm.bing.net/th?id=OIP.gZkjR0eHoYltElzFCNrFdwHaE8&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Pest Control", "Two bedrooms", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg-RT1QEum-tfGqxaAav-OyjzhLwa8hzilsg&usqp=CAU");');
   db.execute('INSERT INTO services VALUES("Pest Control", "Three bedrooms", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkqMdib-Ry6vprXj2PCciK8t03pkYzdPqg9g&usqp=CAU");');

   db.execute('INSERT INTO services VALUES("Sterilization", "One bedroom", "https://tse4.mm.bing.net/th?id=OIP.5SskEP956TZ5s3XtjhTqnAHaD0&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Sterilization", "Two bedrooms", "https://tse1.mm.bing.net/th?id=OIP.jzjBhEvec9y590WoWerARAHaFZ&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Sterilization", "Three bedrooms", "https://tse4.mm.bing.net/th?id=OIP.sebFuK8VrFNZ2znB7bmEcQHaEd&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Sterilization", "Four bedrooms", "https://tse4.mm.bing.net/th?id=OIP.ZbQZdEZYytGy1tuxLgQRVAHaHa&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Sterilization", "Villa", "https://images.squarespace-cdn.com/content/v1/56d5b150f8baf3314c8eae2b/1588092476562-4XFHND1H0GPDLGNEJL9S/COVID19-Disinfection.jpg");');

   db.execute('INSERT INTO services VALUES("Swimming Pool", "Maintenance", "https://tse1.mm.bing.net/th?id=OIP.ON4NRhi3vtiTd09Hpw65_AHaE7&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Swimming Pool", "Cleaning", "https://tse3.mm.bing.net/th?id=OIP.B0WXwzj-WzlcHpxB_cgiAgHaEK&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Swimming Pool", "Insulation", "https://tse1.mm.bing.net/th?id=OIP.R1-dECBjbd0b7qfZTDCWqAAAAA&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Swimming Pool", "Monthly subscription", "https://tse2.mm.bing.net/th?id=OIP.ZgpAtCzTHW1WB-v2YlVuqAHaEL&pid=Api&P=0");');
   db.execute('INSERT INTO services VALUES("Swimming Pool", "Restoration", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGXmRvVi3tRBETLzQI8p5whQcumULFNWQm3cYHS7nul4Fi1mgLbDV6CUjCPWx2zIOXE8Q&usqp=CAU");');

 }

