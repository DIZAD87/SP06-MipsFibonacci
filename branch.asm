#**************************************************************
#Class: CIS580
#Assignment: Lab#02
#Author: Daniel Izadnegahdar
#CsuID#: 2420596
#Program Title: Fibonacci Calculator With MIPS
#Program Description: This program asks the user for their name,...
#...and a number between 1 -47[inclusive].  It error checks to ...
#...make sure the value is inside that range.  Next, it calculates...
#...as many fibonacci numbers as the user provided integer...
#...Finally, it prints a farewell message and exits.
#**************************************************************
#segment block: data segment
#psuedocode: will store all data variables in this segment
  .data
  #mainData
    stringBreak: .asciiz "\n************************************************"
    stringNewLine: .asciiz "\n"
    string4Spaces: .asciiz "    "
    string02: .asciiz "What is your name? "
    string03: .asciiz "Hi, "
    string04: .asciiz "\nHow many Fibonacci numbers should I display?\n"
    string05: .asciiz "Enter an integer in the range [1..47]: "
    string06: .asciiz "That number was out of range, try again.\n"
    string07: .asciiz "\n\nGoodbye, "
    string08: .asciiz "\nAuthor: Daniel Izadnegahdar\n"
    string09: .asciiz "Title: Fibonacci Numbers\n"
    string10: .asciiz "Description: MIPS program that takes a user integer to calculate n many fibonacci numbers.\n"
    string11: .asciiz "\nFibonacci Numbers by, Daniel Izadnegahdar\n\n"
    string13: .asciiz ""
    inputName: .space 64 #resever 64 bytes for input string
  #extraCreditData
    string14: .asciiz "\n\nwould you like to start the ASTOUNDINGLY CREATIVE EXTRA-CREDIT program now?"
    string145: .asciiz "\nenter 1 for yes and 0 for no: "
    string15: .asciiz "\nthe program will start by using an advanced algorithm to identify your profile...\n"
    string16: .asciiz "\n  1)user is facially recognized as a Korean version of Johnny Depp..."
    string17: .asciiz "\n  2)user was a sniper for 2 years in the army..."
    string18: .asciiz "\n  3)user is the best computer science professor at CSU..."
    string19: .asciiz "\n\n...the program identified user as: Dr.Jongman Kim..."
    string20: .asciiz "\n\n...profile scan complete, now a hacker is installing a virus on your computer..."
    string21: .asciiz "\n\n  10% installation complete..."
    string22: .asciiz "\n  18% installation complete..."
    string23: .asciiz "\n  25% installation complete..."    
    string24: .asciiz "\n  27% installation complete..."
    string25: .asciiz "\n  31% installation complete..."
    string26: .asciiz "\n  32% installation complete..."
    string27: .asciiz "\n\nHAULT!!! SOTERIA SYSTEMS has blocked the virus from installing on your computer..."
    string28: .asciiz "\nSOTERIA SYSTEMS will now remove the virus from your computer..."
    string29: .asciiz "\n\n  05% removal complete..."
    string30: .asciiz "\n  15% removal complete..."
    string31: .asciiz "\n  25% removal complete..."
    string32: .asciiz "\n  100% removal complete..."
    string33: .asciiz "\n\nthank you for using SOTERIA SYSTEMS, have a nice day!..."
#**************************************************************
#segment block: text segment
#pseudocode: will print, read, and calculate in this segment
  .text
    main: 
  #section block: print intro
  #pseudocode: this prints the basic intro to the program
    #print:
      li $v0, 4 #4 print string
      la $a0, stringBreak
      syscall
    #print string08: "Author: Daniel Izadnegahdar"
      li $v0, 4 #4 print string
      la $a0, string08
      syscall
    #print string09: "Title: Fibonacci Numbers"
      li $v0, 4 #4 print string
      la $a0, string09
      syscall     
    #print string10: "Description:..."
      li $v0, 4 #4 print string
      la $a0, string10
      syscall
    #print:
      li $v0, 4 #4 print string
      la $a0, stringBreak
      syscall
    #print string11: "\nFibonacci Numbers by, Daniel Izadnegahdar\n"
      li $v0, 4 #4 print string
      la $a0, string11
      syscall
  #section block: prompt for name 
  #pseudocode: this block prompts the user for a name
  #memory map: inputName stores the user string   
    #print string02: "What is your name: "
      li $v0, 4 #4 print string
      la $a0, string02
      syscall
    #read name
      la $a0, inputName #$a0 = inputName
      li $a1, 100 #read up to 100 chars
      li $v0, 8
      syscall
    #print string03: "Hi, "
      la $v0, 4 #4 print string
      la $a0, string03
      syscall
    #print userName
      li $v0, 4 #4 print string
      la $a0, inputName
      syscall
  #section block: prompt for fibonacci count
  #pseudocode: this block prompts the user for the integer count value
  #memory map: $s0 = count
     #while loop
      whileFormat:
         #print string04: "How many Fibonacci numbers should I display: "
           li $v0, 4 #4 print string
           la $a0, string04
           syscall
         #print string05: "Enter an integer in the range [1..47]: "
           li $v0, 4 #4 print string
           la $a0, string05
          syscall
        #read integer
          li $v0, 5 #5 for reading integer
          syscall
          move $s0, $v0
        #addi $s0, $zero, 0
          blt $s0, 48, checkLowerBound #if $s0 <= 47, check lower bound
	  j repeat #notify error and repeat loop
      checkLowerBound:
         bgt $s0, 0, startFibonacci #if $s0 > 1, continue with fibonacci
         j repeat #notify error and repeat loop
      repeat:
         #print string06: "That number was out of range, try again."
           li $v0, 4 #4 print string
           la $a0, string06
           syscall
           j whileFormat #jump back to while loop
   #section block: calculate the fibonacci sequence
   #pseudocode: this block will calculate all of the numbers of the fibonacci sequence up to the user integer
   #mapping: $s0 = user max, $s1= 1st value, $s2 = 2nd value, $s3 = sum, $s7 = counter, $s5 = remainder
       startFibonacci:
         #print stringNewLine:
           li $v0, 4 #4 print string
           la $a0, stringNewLine
           syscall
           move $s7, $zero #set 0 to counter (could have initiated this earlier)
           j whileFibonacci
       whileFibonacci:
         #first 2 numbers are predetermined
           bge $s7, $s0, exit #if count is larger than max, exit
           beq $s7, 0, firstFibonacci
           bge $s7, $s0, exit #if count is larger than max, exit  
           beq $s7, 1, secondFibonacci
           bge $s7, $s0, exit #if count is larger than max, exit 
           beq $s7, 2, thirdFibonacci
           bge $s7, $s0, exit #if count is larger than max, exit  
         #swap $s2 and $s1
           move $s1, $s2  
           move $s2, $s3
           add $s3, $s2, $s1 #$s3 = $s2 + $s1
           move $a0, $s3              
         #print fibonacci number          
           la $v0, 1 #1 print integer 
           syscall        
         #print 4 spaces
           li $v0, 4 #4 print string
           la $a0, string4Spaces
           syscall                                      
         #increment counter by 1
           add $s7, $s7, 1 
         #new line every 5 values
           rem $s5, $s7, 5
           beq $s5, 0, newLine #new line for every 5 values
         #continue to loop fibonacci sequence
           j whileFibonacci 
       firstFibonacci:
         #1st number
           li $s1, 0
           move $a0, $s1  
         #print fibonacci number
           la $v0, 1 #1 print integer
           syscall  
         #print 4 spaces
           li $v0, 4 #4 print string
           la $a0, string4Spaces
           syscall
	 #decrement
           add $s7, $s7, 1 #decrement counter by 1
           j whileFibonacci #continue to loop fibonacci sequence
       secondFibonacci:
         #1st number
           li $s2, 1
           move $a0, $s2  
         #print fibonacci number
           la $v0, 1 #1 print integer
           syscall  
         #print 4 spaces
           li $v0, 4 #4 print string
           la $a0, string4Spaces
           syscall
	 #decrement
           add $s7, $s7, 1 #decrement counter by 1
           j whileFibonacci #continue to loop fibonacci sequence  
       thirdFibonacci:
         #remaining numbers are calculated here
           add $s3, $s2, $s1 # $s3 = $s2 + $s1
           move $a0, $s3                                 
           #print fibonacci number          
           la $v0, 1 #1 print integer 
           syscall        
         #print 4 spaces
           li $v0, 4 #4 print string
           la $a0, string4Spaces
           syscall 
	 #decrement
           add $s7, $s7, 1 #decrement counter by 1
           j whileFibonacci #continue to loop fibonacci sequence   
 	newLine:
         #print 4 spaces
           li $v0, 4 #4 print string
           la $a0, stringNewLine
           syscall
           j whileFibonacci                                                                                                                                              
   #section block: Farewell the user and exit
   #pseudocode:  This begins the farewell sequence, before moving on to the extra credit      
       exit:                                                                                                               
        #print string07: "Goodbye, "
          li $v0, 4 #4 print string
          la $a0, string07
          syscall
        #print userName
          li $v0, 4 #4 print string
          la $a0, inputName
          syscall
        #print:
          li $v0, 4 #4 print string
          la $a0, stringBreak
          syscall
        #extra credit
          j startExtraCredit
       startExtraCredit:
       #delay
         li $v0, 32
         li $a0, 1000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string14
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string145
         syscall
        #read integer
          li $v0, 5 #5 for reading integer
          syscall
          move $s4, $v0  
        #check to see if 1 or 0 was pressed   
          beq $s4, 1, extraCredit #if 0, close program
          j closeProgram
       extraCredit:
       #delay
         li $v0, 32
         li $a0, 500
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string15
         syscall
       #delay
         li $v0, 32
         li $a0, 3000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string16
         syscall
       #delay
         li $v0, 32
         li $a0, 3000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string17
         syscall
       #delay
         li $v0, 32
         li $a0, 3000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string18
         syscall
       #delay
         li $v0, 32
         li $a0, 3500
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string19
         syscall
       #delay
         li $v0, 32
         li $a0, 3000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string20
         syscall
       #delay
         li $v0, 32
         li $a0, 4000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string21
         syscall
       #delay
         li $v0, 32
         li $a0, 500
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string22
         syscall
       #delay
         li $v0, 32
         li $a0, 750
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string23
         syscall
       #delay
         li $v0, 32
         li $a0, 300
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string24
         syscall
       #delay
         li $v0, 32
         li $a0, 500
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string25
         syscall
       #delay
         li $v0, 32
         li $a0, 250
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string26
         syscall
       #delay
         li $v0, 32
         li $a0, 750
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string27
         syscall
       #delay
         li $v0, 32
         li $a0, 4000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string28
         syscall
       #delay
         li $v0, 32
         li $a0, 3000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string29
         syscall
       #delay
         li $v0, 32
         li $a0, 1000
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string30
         syscall
       #delay
         li $v0, 32
         li $a0, 800
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string31
         syscall
       #delay
         li $v0, 32
         li $a0, 700
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string32
         syscall
       #delay
         li $v0, 32
         li $a0, 600
         syscall
       #print:
         li $v0, 4 #4 print string
         la $a0, string33
         syscall
       #delay
         li $v0, 32
         li $a0, 1500
         syscall
       j closeProgram
     closeProgram:
       #print:
         li $v0, 4 #4 print string
         la $a0, stringBreak
         syscall
       #exit
          li $v0 10 #10 to exit program
          syscall
