const db =require('../config/db') ;


exports.addfav = (req, res) => {
  const { pizza_id } = req.body;
  const firebaseUid = req.user.uid;

  const sql1 = "SELECT id FROM users WHERE firebase_uid = ?";
  db.query(sql1, [firebaseUid], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const user_id = result[0].id;

    const sql2 = "INSERT INTO favourites(pizza_id, user_id) VALUES(?, ?)";
    db.query(sql2, [pizza_id, user_id], (err, insertResult) => {
      if (err) return res.status(500).json({ error: err.message });
      res.json(insertResult);
    });
  });
};


exports.removefav=(req,res)=>{
   const { pizza_id } = req.body;
  const firebaseUid = req.user.uid;

  const sql1 = "SELECT id FROM users WHERE firebase_uid = ?";
  db.query(sql1, [firebaseUid], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const user_id = result[0].id;
    const sql ="delete from favourites where pizza_id=? and user_id= ?" ;
    db.query(sql,[pizza_id,user_id],(err,result)=>{
      if(err)  return res.status(500).json({error:err.message}) ;
      res.json(result) ;
 });
});
};


exports.getfavs=(req,res)=>{
  const firebaseUid = req.user.uid;
  const sql1 = "SELECT id FROM users WHERE firebase_uid = ?";
  db.query(sql1, [firebaseUid], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    if (result.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }

    const user_id = result[0].id;
    const sql ="select pizza_id from favourites where user_id=?" ;
    db.query(sql,[user_id],(err,result)=>{
      if(err)  return res.status(500).json({error:err.message}) ;
     res.json(result.map(r => r.pizza_id));
 });
});
};