fun parse file = 
    let
       fun read_int input = 
           Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
           
       val input_stream = TextIO.openIn file
       
       val n = read_int input_stream
       val k = read_int input_stream
       val _ = TextIO.inputLine input_stream
       
       fun read_ints 0 acc = acc 
         | read_ints i acc = read_ints (i - 1) (read_int input_stream :: acc)
    in 
       (n, k, rev(read_ints n []))
    end

fun first (x:int, _:int, _:int list) = x
fun second (_:int, y:int, _:int list) = y
fun third (_:int, _:int, z:int list) = z

fun get_color l x = List.nth (l, x) - 1

fun addition number addednumber = 
    let
      val number = number + addednumber
    in
      number
    end
   
 
fun updateArray arr l j number  =
    let
       val x = get_color l j
       val y = Array.sub (arr, x)
       val z = addition y number
       val change = Array.update (arr, x, z)
       val newArray = arr  
    in
      newArray
    end

fun checkArray arr l j =
    let
       val y = get_color l j
       val check = Array.sub (arr, y)   
    in
      check
    end
 
fun loopj (arr:int array) (l:int list) (counter:int) (i:int) (j:int) (final_answer:int array) (n:int) = 
    let
       val newcounter = if checkArray arr l j = 0 then addition counter ~1 
                        else counter 
       val newarr = updateArray arr l j 1 
       val newj = j + 1  
    in 
      if ((j<n orelse counter=0) andalso counter>0) then loopj newarr l newcounter i newj final_answer n
      else if ((j<n orelse counter=0) andalso counter=0) then loopi newarr l newcounter i newj final_answer n 
      else loopend final_answer
    end 
and loopi (arr:int array) (l:int list) (counter:int) (i:int) (j:int) (final_answer:int array) (n:int) = 
    let
       val final_answernum = Array.sub(final_answer, 0)
       val answer = if (j + (~i) < final_answernum) then addition j (~i)
                    else final_answernum
       val newanswer = Array.update(final_answer, 0, answer)
       val newarr = updateArray arr l i ~1
       val newcounter = if checkArray arr l i = 0 then addition counter 1 
                        else counter
       val newi = i + 1
    in
      if ((j<n orelse counter=0) andalso counter>0) then loopj newarr l newcounter newi j final_answer n
      else if ((j<n orelse counter=0) andalso counter=0) then loopi newarr l newcounter newi j final_answer n 
      else loopend final_answer
    end
and loopend final_answer = final_answer

fun colors fileName =  
    let 
       val n = first (parse (fileName))
       val k = second (parse (fileName))
       val l = third (parse (fileName))
       val arr = Array.array (k, 0)
       val counter = k
       val i = 0
       val j = 0
       val final_answer_array = Array.array (1, n+1)
       val compute = loopj arr l counter i j final_answer_array n
       val final_answer = Array.sub (final_answer_array, 0)
    in 
       if final_answer = n+1 then print (Int.toString 0 ^ "\n")
       else                       print (Int.toString final_answer ^ "\n")
    end
