const db =require('../config/db') ;

exports.createUser=(req,res)=>{
    
  const {name ,email,phoneNumber,location}=req.body ;

  const uid=req.user.uid ;

  const sql = `
    INSERT INTO users (firebase_uid, name, email, phone_number,location) 
    VALUES (?, ?, ?, ?,?)
    ON DUPLICATE KEY UPDATE 
      name = VALUES(name), 
      email = VALUES(email), 
      phone_number = VALUES(phone_number),
      location=VALUES(location)
  `;  db.query(sql,[uid,name,email,phoneNumber,location],(err) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json({ message: "User saved successfully" });
});

}


exports.getUser=(req,res)=>{
    const uid=req.user.uid ;
    const sql="select * from users where firebase_uid=?" ;
    db.query(sql,[uid],(err,result)=>{
        if(err) return res.status(500).json({error:err.message}) ;
        res.json(result[0]);
        
    })

}