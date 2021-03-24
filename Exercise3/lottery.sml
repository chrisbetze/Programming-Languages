fun parse file =
	let
		fun read_int input = 
           Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
        
        fun read_string input =
           Option.valOf (TextIO.inputLine input)
              
        val input_stream = TextIO.openIn file
        
        val k = read_int input_stream
        val n = read_int input_stream
        val q = read_int input_stream
        val _ = TextIO.inputLine input_stream
        
        fun scanner 0 acc = acc
          | scanner i acc =
        	let
        		val d = read_string input_stream
            in
            	scanner (i - 1) (d :: acc)
            end	      	
	in
		(k, n, q, scanner n [], rev(scanner q []))
	end

fun first (x:int, _:int, _:int, _:string list, _:string list) = x
fun second (_:int, y:int, _:int, _:string list, _:string list) = y
fun third (_:int, _:int, z:int, _:string list, _:string list) = z
fun fourth (_:int, _:int, _:int, w:string list, _:string list) = w
fun fifth (_:int, _:int, _:int, _:string list, v:string list) = v

structure S = BinaryMapFn(struct
    type ord_key = string
    val compare = String.compare
end); 

fun power 0 k:IntInf.int = 1
  | power n k = k * (power (n-1) k)
            
fun insertallSubstrings t x 0 = t
  | insertallSubstrings t x k =
	 let
	 	 val substr = String.extract(x, k-1, NONE)
	 	 val value = Option.getOpt(S.find(t, substr), 0) + 1
	 	 val tree = S.insert (t, substr, value)
	 in
	     insertallSubstrings tree x (k-1)
	 end 
	  
fun insertfromListtoMap t [] k = t
  | insertfromListtoMap t (x :: xs) k = 
     let
         val length = k
         val tree = insertallSubstrings t x length
     in
         insertfromListtoMap tree xs k
     end
     
fun nrofWinners t str k = 
	let
	    val winners = Option.getOpt(S.find(t, String.extract(str, (k-1), NONE)), 0) 
	in
		winners
	end
	
fun findWinningSum t str 0 k acc:IntInf.int = acc
  | findWinningSum t str pos k acc:IntInf.int = 
     let
         val cur_winners = LargeInt.fromInt(Option.getOpt(S.find(t, String.extract(str, (pos-1), NONE)), 0))
         val exp = cur_winners*((power (k-pos+1) 2) - 1) - cur_winners*((power (k-pos) 2) - 1)
         val accumulated = (acc + exp) mod ((power 9 10) + 7)
     in
        if cur_winners = 0 then (accumulated mod ((power 9 10) + 7))
        else findWinningSum t str (pos-1) k accumulated
     end

fun aux_lottery t [] k = ()
  | aux_lottery t (x :: xs) k = 
     let
     	 val win = nrofWinners t x k 
     	 val acc = Int.fromLarge (findWinningSum t x k k 0)
     in
         print((Int.toString(win)) ^ " " ^ (Int.toString(acc)) ^ "\n");
         aux_lottery t xs k
     end
         	
fun lottery fileName =
    let
    	val k = first (parse (fileName))
		val n = second (parse (fileName))
		val q = third (parse (fileName))
		val n_list = fourth (parse (fileName))
		val q_list = fifth (parse (fileName))
		val tree = S.empty
		val tree = insertfromListtoMap tree n_list k	
	in
		aux_lottery tree q_list k
	end 
