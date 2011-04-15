
m_start_ai  be      m_y_val     zero        zero
m_y_val	be	AFTER 		m_y		m_8
	add 	m_y 		m_y 		m_1
	cp	m_x		m_0
	cp	m_x_index	m_0	

	be	m_even		m_y		m_1
	be	m_odd		m_y		m_2
	be	m_even		m_y		m_3
	be	m_odd		m_y		m_4
	be	m_even		m_y		m_5
	be	m_odd		m_y		m_6
	be	m_even		m_y		m_7
	be	m_odd		m_y		m_8

m_even	cpta	m_2		m_x_array	m_0
	cpta	m_4		m_x_array	m_1
	cpta	m_6		m_x_array	m_2
	cpta	m_8		m_x_array	m_3

	be	m_x_val		m_1		m_1


m_odd	cpta	m_1		m_x_array	m_0
	cpta	m_3		m_x_array	m_1
	cpta	m_5		m_x_array	m_2
	cpta	m_7		m_x_array	m_3

	be	m_x_val		m_1		m_1

m_x_val	be 	m_y_val		m_x_index	m_4	
	
	cpfa	m_x		m_x_array	m_x_index	
	add	m_x_index	m_x_index	m_1

//	m_piece = get value at (x,y)
	cp	calc_pos_x	m_x
	cp	calc_pos_y	m_y
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	blt	m_x_val		m_N1		m_piece
	be	m_reg		m_N1		m_piece
	blt	m_king		m_piece		m_N1

//--------------------------------------			Figures out which regular pieces can move an capture
m_reg	add	m_xL		m_N1		m_x
	add	m_xR		m_1		m_x
	add	m_y+		m_1		m_y

								//LEFT_DOWN
check_L	blt	check_R		m_xL		m_1		//check if left is out of bounds
								//m_p@xL = get new value at (x-1,y+1) = = (m_xL,m_y+) this gets what piece is at the xL space
	cp	calc_pos_x	m_xL	
	cp	calc_pos_y	m_y+
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xL		board		calc_pos_end

	blt	check_R		m_p@xL		m_0				
	be	ZERO_L		m_p@xL		m_0

enemy_L	add	m_xLL		m_N1		m_xL		// x--
	add 	m_y++		m_1		m_y+		// y++
	
	blt	check_R		m_xLL		m_1		//check if m_xLL & m_y++ are out of bounds. if so, go to check_R
	blt	check_R		m_8		m_y++		
								//m_p@xLL = the piece at (x-2,y+2) = = (m_xLL, m_y++)
	cp	calc_pos_x	m_xLL	
	cp	calc_pos_y	m_y++
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xLL		board		calc_pos_end

	cp	m_xLL		m_0
	cp	m_y++		m_0

	bne	check_R		m_p@xLL		m_0		// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece
	
	cpta	m_x		m_x_cap_L	num_cap_L
	cpta	m_y		m_y_cap_L	num_cap_L
	add	num_cap_L	m_1		num_cap_L
	be	check_R		m_1		m_1

ZERO_L	cpta	m_x		m_x_mov_L	num_mov_L
	cpta	m_y		m_y_mov_L	num_mov_L
	add	num_mov_L	m_1		num_mov_L
	be	check_R		m_1		m_1


								//RIGHT_DOWN

check_R	blt	m_x_val		m_8		m_xR		// check if right is out of bounds


							//m_p@xR = get new value at (x+1,y+1) = = (m_xR,m_y+) this gets what piece is at the xR space
	cp	calc_pos_x	m_xR	
	cp	calc_pos_y	m_y+
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xR		board		calc_pos_end




	blt	m_x_val		m_p@xR		m_0
	be	ZERO_R		m_p@xR		m_0

enemy_R	add	m_xRR		m_1		m_xR		// x++
	add 	m_y++		m_1		m_y+		// y++
	
	blt	m_x_val		m_8		m_xRR
	blt	m_x_val		m_8		m_y++		
								//check if m_xRR & m_y++ are out of bounds. if so, go to x_val

								//m_p@xRR = the piece at (x+2,y+2) = = (m_xRR, m_y++)

	cp	calc_pos_x	m_xRR	
	cp	calc_pos_y	m_y++
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xRR		board		calc_pos_end	

	
	cp	m_xRR		m_0
	cp	m_y++		m_0

	bne	m_x_val		m_p@xRR		m_0				// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece

	cpta	m_x		m_x_cap_R	num_cap_R
	cpta	m_y		m_y_cap_R	num_cap_R
	add	num_cap_R	m_1		num_cap_R
	be	m_x_val		m_1		m_1

	

ZERO_R	cpta	m_x		m_x_mov_R	num_mov_R
	cpta	m_y		m_y_mov_R	num_mov_R
	add	num_mov_R	m_1		num_mov_R
	be	m_x_val		m_1		m_1



//	KING		---->>>>			*THIS AREA IS WHERE KINGS ARE CONTROLED!@@###$$$$%%%%%^^^^^^&&&&&&&********((((((((())))))))))*		<<<<<-------

m_king	add	m_y+		m_1		m_y	
	add	m_y-		m_N1		m_y					
	add	m_xL		m_N1		m_x
	add	m_xR		m_1		m_x
			
	be	chk_LU		m_8		m_y				
	
//LEFT_DOWN_King 	(m_xL, m_y+)

chk_LD	blt	chk_RD		m_xL		m_1		//check if left is out of bounds
	
	cp	calc_pos_x	m_xL
	cp 	calc_pos_y	m_y+ 		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_p@xL	 	board 	calc_pos_end						
								//m_p@xL = get new value at (x-1,y+1) = = (m_xL,m_y+) this gets what piece is at the xL space

	blt	chk_RD		m_p@xL		m_0				
	be	ZERO_LD		m_p@xL		m_0

enem_LD	add	m_xLL		m_N1		m_xL		// x--
	add 	m_y++		m_1		m_y+		// y++
	
	blt	chk_RD		m_xLL		m_1		//check if m_xLL & m_y++ are out of bounds. if so, go to check_R
	blt	chk_RD		m_8		m_y++

								//m_p@xLL = the piece at (x-2,y+2) = = (m_xLL, m_y++)
	cp	calc_pos_x	m_xLL
	cp	calc_pos_y	m_y++
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xLL		board		calc_pos_end

	cp	m_xLL		m_0
	cp	m_y++		m_0

	bne	chk_RD		m_p@xLL		m_0		// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece
	
	cpta	m_x		m_x_cap_L	num_cap_L
	cpta	m_y		m_y_cap_L	num_cap_L
	add	num_cap_L	m_1		num_cap_L
	be	check_R		m_1		m_1

ZERO_LD	cpta	m_x		m_x_mov_L	num_mov_L
	cpta	m_y		m_y_mov_L	num_mov_L
	add	num_mov_L	m_1		num_mov_L
	be	chk_RD		m_1		m_1


//RIGHT_DOWN_King	(m_xR, m_y+)

chk_RD	blt	chk_LU		m_8		m_xR		// check if right is out of bounds

	cp	calc_pos_x	m_xR				//m_p@xR = get new value at (x+1,y+1) = = (m_xR,m_y+) this gets what piece is at the xR space
	cp	calc_pos_y	m_y+
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xR		board		calc_pos_end

	blt	chk_LU		m_p@xR		m_0
	be	ZERO_RD		m_p@xR		m_0

enem_RD	add	m_xRR		m_1		m_xR		// x++
	add 	m_y++		m_1		m_y+		// y++
	
	blt	chk_LU		m_8		m_xRR		//check if m_xRR & m_y++ are out of bounds. if so, go to x_val
	blt	chk_LU		m_8		m_y++		//m_p@xRR = the piece at (x+2,y+2) = = (m_xRR, m_y++)
	
	cp	calc_pos_x	m_xRR
	cp	calc_pos_y	m_y++
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xRR		board		calc_pos_end
	

	cp	m_xLL		m_0
	cp	m_y++		m_0

	bne	chk_LU		m_p@xRR		m_0				// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece

	cpta	m_x		m_x_cap_R	num_cap_R
	cpta	m_y		m_y_cap_R	num_cap_R
	add	num_cap_R	m_1		num_cap_R
	be	chk_LU		m_1		m_1

	

ZERO_RD	cpta	m_x		m_x_mov_R	num_mov_R
	cpta	m_y		m_y_mov_R	num_mov_R
	add	num_mov_R	m_1		num_mov_R
	be	chk_LU		m_1		m_1

// LEFT_UP_king		(m_xL, m_y-)

chk_LU	blt	chk_RU		m_xL		m_1		//check if left is out of bounds
	

	cp	calc_pos_x	m_xL
	cp 	calc_pos_y	m_y- 		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_p@xL	 	board 	calc_pos_end						
								//m_p@xL = get new value at (x-1,y-1) = = (m_xL,m_y-) this gets what piece is at the xL space

	blt	chk_RU		m_p@xL		m_0				
	be	ZERO_LU		m_p@xL		m_0

enem_LU	add	m_xLL		m_N1		m_xL		// x--
	add 	m_y--		m_N1		m_y-		// y--
	
	blt	chk_RU		m_xLL		m_1		//check if m_xLL & m_y-- are out of bounds. if so, go to chk_RU
	blt	chk_RU		m_y--		m_1

								//m_p@xLL = the piece at (x-2,y+2) = = (m_xLL, m_y++)
	cp	calc_pos_x	m_xLL
	cp	calc_pos_y	m_y--
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xLL		board		calc_pos_end

	cp	m_xLL		m_0
	cp	m_y++		m_0

	bne	chk_RU		m_p@xLL		m_0		// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece
	
	cpta	m_x		m_xk_cap_LU	num_cap_LU
	cpta	m_y		m_yk_cap_LU	num_cap_LU
	add	num_cap_LU	m_1		num_cap_LU
	be	chk_RU		m_1		m_1

ZERO_LU	cpta	m_x		m_xk_mov_LU	num_mov_LU
	cpta	m_y		m_yk_mov_LU	num_mov_LU
	add	num_mov_LU	m_1		num_mov_LU
	be	chk_RU		m_1		m_1



// RIGHT_UP_king	(m_xR, m_y-)

chk_RU	blt	m_x_val		m_8		m_xR		// check if right is out of bounds

	cp	calc_pos_x	m_xR				//m_p@xR = get new value at (x+1,y-1) = = (m_xR,m_y-) this gets what piece is at the xR space
	cp	calc_pos_y	m_y-
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xR		board		calc_pos_end

	blt	m_x_val		m_p@xR		m_0
	be	ZERO_RU		m_p@xR		m_0

enem_RU	add	m_xRR		m_1		m_xR		// x++
	add 	m_y--		m_N1		m_y-		// y--
	
	blt	m_x_val		m_8		m_xRR		//check if m_xRR & m_y++ are out of bounds. if so, go to x_val
	blt	m_x_val		m_y--		m_1		//m_p@xRR = the piece at (x+2,y-2) = = (m_xRR, m_y--)
	
	cp	calc_pos_x	m_xRR
	cp	calc_pos_y	m_y--
	call	calc_pos	calc_pos_retvar
	cpfa	m_p@xRR		board		calc_pos_end
	
	cp	m_xLL		m_0
	cp	m_y++		m_0

	bne	m_x_val		m_p@xRR		m_0				// if its 0 the enemy piece can be captured (open space on other side of enemy) continue and record this piece

	cpta	m_x		m_xk_cap_RU	num_cap_RU
	cpta	m_y		m_yk_cap_RU	num_cap_RU
	add	num_cap_RU	m_1		num_cap_RU
	be	m_x_val		m_1		m_1

ZERO_RU	cpta	m_x		m_xk_mov_RU	num_mov_RU
	cpta	m_y		m_yk_mov_RU	num_mov_RU
	add	num_mov_RU	m_1		num_mov_RU
	be	m_x_val		m_1		m_1



//_===============================================>>>>>>>>>>>>>>>>>>>>>>	AFTER 		<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<================================

AFTER	cp	m_both_chk	m_0

	be	cap_kLU		m_alt		m_0				//alternate moving & capturing right and left
	be	cap_kRU		m_alt		m_1

//king capturing Left Up
cap_kLU	be	m_cap_L		m_both_chk	m_2				//makes sure to that both right and left capturing have been tried
	add	m_both_chk	m_both_chk	m_1
	blt	cap_kRU		num_cap_LU	m_1

	cp	m_xL		m_0
	cp	m_y-		m_0
	cp	m_xLL		m_0
	cp	m_y--		m_0

	cpfa	m_x		m_xk_cap_LU	m_0				//will always cap enemy closest to own side
	cpfa	m_y		m_yk_cap_LU	m_0

	cp	calc_pos_x	m_x						//get piece that can capture
	cp	calc_pos_y	m_y
	call	calc_pos	calc_pos_retvar
	cpfa	m_type		board		calc_pos_end

	cpta	m_0		board		calc_pos_end			//make original spot of the peice 0 becasue it is empty now

	add	m_xL		m_x		m_N1				//get coordinates for position of enemy piece
	add	m_y-		m_y		m_N1

	cp	calc_pos_x	m_xL						//get position in array of enemy piece
	cp	calc_pos_y	m_y-
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	cpta	m_0		board		calc_pos_end			//make position of enemy piece 0 for empty

	add	m_xLL		m_xL		m_N1				//get coordinates of final square
	add	m_y--		m_y-		m_N1

	cp	calc_pos_x	m_xLL						//get position in array of final space
	cp	calc_pos_y	m_y--
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	cpta	m_N2		board		calc_pos_end

	be	m_sub0		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub0	add	m_alt		m_alt		m_N1

	be	cap_L		m_1		m_1
		

//King capturing Right Up
cap_kRU	be	m_cap_R		m_both_chk	m_2
	add	m_both_chk	m_both_chk	m_1
	blt	cap_kLU		num_cap_RU	m_1

	cp	m_xR		m_0
	cp	m_y-		m_0
	cp	m_xRR		m_0
	cp	m_y--		m_0

	add	num_cap-	num_cap_RU	m_N1

	cpfa	m_x		m_xk_cap_RU	num_cap-			//will always cap enemy farthest from own side
	cpfa	m_y		m_yk_cap_RU	num_cap-

	cp	num_cap-	m_0

	cp	calc_pos_x	m_x						//get piece that can capture
	cp	calc_pos_y	m_y
	call	calc_pos	calc_pos_retvar
	cpfa	m_type		board		calc_pos_end

	cpta	m_0		board		calc_pos_end			//make original spot of the peice 0 becasue it is empty now

	add	m_xR		m_x		m_1				//get coordinates for position of enemy piece
	add	m_y-		m_y		m_N1

	cp	calc_pos_x	m_xR						//get position in array of enemy piece
	cp	calc_pos_y	m_y-
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	cpta	m_0		board		calc_pos_end			//make position of enemy piece 0 for empty

	add	m_xRR		m_xR		m_1				//get coordinates of final square
	add	m_y--		m_y-		m_N1

	cp	calc_pos_x	m_xRR						//get position in array of final space
	cp	calc_pos_y	m_y--
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end


	cpta	m_N2		board		calc_pos_end

	be	m_sub1		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub1	add	m_alt		m_alt		m_N1

	be	cap_L		m_1		m_1

//capturing LEFT and Down
m_cap_L	be	m_movLD		m_both_chk	m_4				//makes sure to that both right and left capturing have been tried
	add	m_both_chk	m_both_chk	m_1
	blt	m_cap_R		num_cap_L	m_1			

	cp	m_xL		m_0
	cp	m_y+		m_0
	cp	m_xLL		m_0
	cp	m_y++		m_0

	cpfa	m_x		m_x_cap_L	m_0				//will always cap enemy closest to own side
	cpfa	m_y		m_y_cap_L	m_0
	
	cp	calc_pos_x	m_x						//get piece that can capture
	cp 	calc_pos_y	m_y 		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_type		board 	calc_pos_end

	cpta	m_0		board		calc_pos_end			//make original spot of the peice 0 becasue it is empty now

	add	m_xL		m_x		m_N1				//get coordinates for position of enemy piece
	add	m_y+		m_y		m_1

	cp	calc_pos_x	m_xL						//get position in array of enemy piece
	cp 	calc_pos_y	m_y+		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_piece		board 	calc_pos_end

	
	cpta	m_0		board		calc_pos_end			//make position of enemy piece 0 for empty

	add	m_xLL		m_xL		m_N1				//get coordinates of final square
	add	m_y++		m_y+		m_1

	cp	calc_pos_x	m_xLL						//get position in array of final space
	cp 	calc_pos_y	m_y++		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_piece		board 	calc_pos_end

	be	m_-2_1		m_y++		m_8				//kings regular pieces
	be	m_-2_1		m_type		m_N2
	cpta	m_N1		board		calc_pos_end			//convert position after enemy piece -1 for our piece
	be	m_alt1		m_1		m_1

m_-2_1	cpta	m_N2		board		calc_pos_end


m_alt1	be	m_sub2		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub2	add	m_alt		m_alt		m_N1

	be	cap_L		m_1		m_1



//Capturing right and down the board	
m_cap_R	be	m_movRD	m_both_chk	m_4
	add	m_both_chk	m_both_chk	m_1
	blt	m_cap_L		num_cap_R	m_1

	cp	m_xR		m_0
	cp	m_y		m_0
	cp	m_xRR		m_0
	cp	m_y++		m_0

	add	num_cap-	num_cap_R	m_N1

	cpfa	m_x		m_x_cap_R	num_cap-			//will always cap enemy farthest from own side
	cpfa	m_y		m_y_cap_R	num_cap-
	
	cp	num_cap-	m_0

	cp	calc_pos_x	m_x						//get piece that can capture
	cp 	calc_pos_y	m_y 		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_type		board 	calc_pos_end

	cpta	m_0		board		calc_pos_end			//make original spot of the peice 0 becasue it is empty now

	add	m_xR		m_x		m_1				//get coordinates for position of enemy piece
	add	m_y+		m_y		m_1

	cp	calc_pos_x	m_xR						//get position in array of enemy piece
	cp 	calc_pos_y	m_y+		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_piece		board 	calc_pos_end

	cpta	m_0		board		calc_pos_end			//make position of enemy piece 0 for empty

	add	m_xRR		m_xR		m_1				//get coordinates of final square
	add	m_y++		m_y+		m_1

	cp	calc_pos_x	m_xRR						//get position in array of final space
	cp 	calc_pos_y	m_y++		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_piece		board 	calc_pos_end
	
	be	m_-2_2		m_y++		m_8				//will king a regular piece that lands on the last row.
	be	m_-2_2		m_type		m_N2
	cpta	m_N1		board		calc_pos_end			//convert position after enemy piece -1 for our piece
	be	m_alt2		m_1		m_1

m_-2_2	cpta	m_N2		board		calc_pos_end


m_alt2	be	m_sub3		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub3	add	m_alt		m_alt		m_N1

	be	cap_L		m_1		m_1
		
										//alternates left and right movement if no piece is captured

m_movLD	be	m_movLU		m_both_chk	m_6
	add	m_both_chk	m_both_chk	m_1
	blt	m_movRD		num_mov_L	m_1

	cp	m_y+		m_0
	cp	m_xL		m_0

	cpfa	m_x		m_x_mov_L	m_0
	cpfa	m_y		m_y_mov_L	m_0

		
	cp	calc_pos_x	m_x						//get piece that can capture
	cp 	calc_pos_y	m_y 		
	call 	calc_pos 	calc_pos_retvar
	cpfa 	m_type		board 	calc_pos_end
	
	cpta	m_0		board		calc_pos_end
	
	add	m_y+		m_y	m_1
	add	m_xL		m_x	m_N1

	cp	calc_pos_x	m_xL
	cp	calc_pos_y	m_y+	
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	be	m_-2_3		m_y+		m_8
	be	m_-2_3		m_type		m_N2
	cpta	m_N1		board		calc_pos_end			//convert position after enemy piece -1 for our piece
	be	m_alt3		m_1		m_1
	
m_-2_3	cpta	m_N2		board		calc_pos_end

m_alt3	be	m_sub4		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub4	add	m_alt		m_alt		m_N1

	be	cap_L		m_1		m_1


m_movRD	be	m_movRU		m_both_chk	m_6
	add	m_both_chk	m_both_chk	m_1
	blt	m_movLD		num_mov_R	m_1

	cp	m_y+		m_0
	cp	m_xR		m_0

	add	num_mov-	num_mov_R	m_N1

	cpfa	m_x		m_x_mov_R	num_mov-			
	cpfa	m_y		m_y_mov_R	num_mov-

	cp	num_mov-	m_0

	cp	calc_pos_x	m_x
	cp	calc_pos_y	m_y	
	call	calc_pos	calc_pos_retvar
	cpfa	m_type		board		calc_pos_end

	cpta	m_0		board		calc_pos_end

	add	m_y+		m_y		m_1
	add	m_xR		m_x		m_1

	cp	calc_pos_x	m_xR
	cp	calc_pos_y	m_y+
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	be	m_-2_4		m_y+		m_8
	be	m_-2_4		m_type		m_N2
	cpta	m_N1		board		calc_pos_end			//convert position after enemy piece -1 for our piece
	be	m_alt4		m_1		m_1

m_-2_4	cpta	m_N2		board		calc_pos_end

m_alt4	be	m_sub5		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub5	add	m_alt		m_alt		m_N1
	be	cap_L		m_1		m_1



m_movRU	be	cap_L		m_both_chk	m_8
	add	m_both_chk	m_both_chk	m_1
	blt	m_movLU		num_mov_RU	m_1

	cp	m_y-		m_0
	cp	m_xR		m_0

	add	num_mov-	num_mov_LU	m_N1

	cpfa	m_x		m_xk_mov_RU	num_mov-
	cpfa	m_y		m_yk_mov_RU	num_mov-

	cp	num_mov-	m_0

	cp	calc_pos_x	m_x
	cp	calc_pos_y	m_y
	call	calc_pos	calc_pos_retvar
	cpfa	m_type		board		calc_pos_end	

	cpta	m_0		board		calc_pos_end

	add	m_y-		m_y		m_N1
	add	m_xR		m_x		m_1

	cp	calc_pos_x	m_xR
	cp	calc_pos_y	m_y-
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	cpta	m_N2		board		calc_pos_end

	be	m_sub6		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub6	add	m_alt		m_alt		m_N1
	be	cap_L		m_1		m_1

m_movLU	be	cap_L		m_both_chk	m_8
	add	m_both_chk	m_both_chk	m_1
	blt	m_movRU		num_mov_LU	m_1

	cp	m_y-		m_0
	cp	m_xL		m_0

	cpfa	m_x		m_xk_mov_LU	m_0
	cpfa	m_y		m_yk_mov_LU	m_0

	cp	calc_pos_x	m_x
	cp	calc_pos_y	m_y
	call	calc_pos	calc_pos_retvar
	cpfa	m_type		board		calc_pos_end

	cpta	m_0		board		calc_pos_end

	add	m_y-		m_y		m_N1
	add	m_xL		m_x		m_N1
	
	cp	calc_pos_x	m_xL	
	cp	calc_pos_y	m_y-
	call	calc_pos	calc_pos_retvar
	cpfa	m_piece		board		calc_pos_end

	cpta	m_N2		board		calc_pos_end

	be	m_sub7		m_alt		m_1
	add	m_alt		m_alt		m_1

	be	cap_L		m_1		m_1

m_sub7	add	m_alt		m_alt		m_N1
	be	cap_L		m_1		m_1


//RESETTING THE MEMORY BEFORE BEGINING
cap_L	cpta	m_0		m_x_cap_L	num_cap_L
	cpta	m_0		m_y_cap_L	num_cap_L
	add	num_cap_L	m_N1		num_cap_L
	bne	cap_L		m_N1		num_cap_L
	cp	num_cap_L	m_0

cap_R	cpta	m_0		m_x_cap_R	num_cap_R
	cpta	m_0		m_y_cap_R	num_cap_R
	add	num_cap_R	m_N1		num_cap_R	
	bne	cap_R		m_N1		num_cap_R
	cp	num_cap_R	m_0

mov_L	cpta	m_0		m_x_mov_L	num_mov_L
	cpta	m_0		m_y_mov_L	num_mov_L
	add	num_mov_L	m_N1		num_mov_L
	bne	mov_L		m_N1		num_mov_L
	cp	num_mov_L	m_0

mov_R	cpta	m_0		m_x_mov_R	num_mov_R
	cpta	m_0		m_y_mov_R	num_mov_R
	add	num_mov_R	m_N1		num_mov_R
	bne	mov_R		m_N1		num_mov_R
	cp	num_mov_R	m_0
	
cap_LU	cpta	m_0		m_xk_cap_LU	num_cap_LU
	cpta	m_0		m_yk_cap_LU	num_cap_LU
	add	num_cap_LU	m_N1		num_cap_LU
	bne	mov_LU		m_N1		num_cap_LU
	cp	num_cap_LU	m_0

cap_RU	cpta	m_0		m_xk_cap_RU	num_cap_RU
	cpta	m_0		m_yk_cap_RU	num_cap_RU
	add	num_cap_RU	m_N1		num_cap_RU
	bne	cap_RU		m_N1		num_cap_RU
	cp	num_cap_RU	m_0

mov_RU	cpta	m_0		m_xk_mov_RU	num_mov_RU
	cpta	m_0		m_yk_mov_RU	num_mov_RU
	add	num_mov_RU	m_N1		num_mov_RU
	bne	mov_RU		m_N1		num_mov_RU
	cp	num_mov_RU	m_0

mov_LU	cpta	m_0		m_xk_mov_LU	num_mov_LU
	cpta	m_0		m_yk_mov_LU	num_mov_LU	
	add	num_mov_LU	m_N1		num_mov_LU
	bne	mov_LU		m_N1		num_mov_LU
	cp	num_mov_LU	m_0


	cp	m_y	m_0

end	ret     m_retvar

m_retvar    .data   0
m_y		.data 0
m_x		.data 0
m_N2		.data -2
m_N1		.data -1
m_0		.data 0
m_1		.data 1
m_2		.data 2
m_3		.data 3
m_4		.data 4
m_5		.data 5
m_6		.data 6
m_7		.data 7
m_8		.data 8
m_y+		.data 0		// next row DOWN
m_xL		.data 0		// square one to the LEFT
m_xR		.data 0		// square one to the RIGHT
m_p@xL		.data 0		// piece at xL
m_p@xR		.data 0		// piece at xR
m_y++		.data 0		// 2 spaces DOWN from original square	used to see if it is open so a piece can be captured
m_xLL		.data 0		// 2 spaces to the LEFT of original	used to see if it is open so a piece can be captured
m_xRR		.data 0		// 2 spaces to the RIGHT of original	used to see if it is open so a piece can be captured
m_p@xLL		.data 0		// piece located 2 spaces DOWN & LEFT
m_p@xRR		.data 0		// piece located 2 spaces DOWN & RIGHT
m_pos_return	.data 0		// place to return after getting the piece at a (x,y) in the board
m_y-		.data 0		// when kings move back UP
m_y--		.data 0		// when kings move back UP
m_type		.data 0
m_alt		.data 0
m_alt_k		.data 0
m_piece		.data 0
m_both_chk	.data 0

m_x_index	.data 0
m_x_array	.data 0
		.data 0
		.data 0
		.data 0


set_to_0	.data -1
num_cap-	.data 0


num_cap_L	.data 0		//have to keep track of # of peices that can capture moving LEFT.
m_y_cap_L	.data 0		//y value of pieces that can capture LEFT
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_x_cap_L	.data 0		// x value of peices that can capture LEFT
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0


num_cap_R	.data 0		//have to keep track of # of peices that can capture RIGHT
m_y_cap_R	.data 0		//y value of pieces that can capture RIGHT
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_x_cap_R	.data 0		// x value of peices that can capture RIGHT
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0


num_cap_LU	.data 0
m_xk_cap_LU	.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_yk_cap_LU	.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

num_cap_RU	.data 0
m_xk_cap_RU	.data 0		//fjdksal;jfdklas;jfkdls;a
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_yk_cap_RU	.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

num1		.data -2
//----------------------------------------------------------------------------------------------------------------
num_mov-	.data 0

num_mov_L	.data 0		//have to keep track of # of peices that can move LEFT
m_y_mov_L	.data 0		//y value of pieces that can move LEFT
		.data 0
		.data 0 	
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_x_mov_L	.data 0		// x value of peices that can move LEFT
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

num2		.data -3
num_mov_R	.data 0		//have to keep track of # of peices that can move.
m_y_mov_R	.data 0		//y value of pieces that can move
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_x_mov_R	.data 0		// x value of peices that can move
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

num4		.data -4
num_mov_RU	.data 0
m_yk_mov_RU	.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_xk_mov_RU	.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
num5		.data -5
num_mov_LU	.data 0
m_yk_mov_LU	.data 0		//was (m_yk_mov_LU)
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

m_xk_mov_LU	.data 0		//was (m_xk_mov_LU)
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0
		.data 0

numend		.data -3
