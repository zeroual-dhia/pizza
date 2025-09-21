
const db =require('../config/db') ;


exports.getPizzas=(req,res)=>{
    
 const sql = 'select * from pizzas ';
 db.query(sql,(err,result)=>{
   if (err) return res.status(500).json({error:err.message}) ;
   res.json(result)
 }) ;
  
}

