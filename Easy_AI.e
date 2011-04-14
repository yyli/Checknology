// Code for AI assuming it is Red and Easyish
// 2 is Black King
// 1 is Black Piece
// 0 is blank
// -1 is Red Piece
// -2 is Red King

//e_Check_start     bne  e_Check_start   e_ai_on_e          one
e_start_ai      call e_rand_num_gen  e_retvar_rand
						cp   e_pos           e_randnum
						out	3	e_pos
						cpfa e_x             board_pos_x      e_pos       
						cpfa e_y             board_pos_y      e_pos
e_Pick_Piece      cp   calc_pos_x      e_x
						cp   calc_pos_y      e_y
						call calc_pos        calc_pos_retvar
						cpfa e_Own_Piece     board            calc_pos_end
// Checking for Red piece
e_Check_Red_Piece bne  e_Check_King      e_Own_Piece      e_Red
						add  e_dx_pos          e_x              one
						sub  e_dx_neg          e_x              one
						add  e_dy_pos          e_y              one

						be   e_Check_OMLL      e_dx_pos         nine         
						be   e_Check_OMLR      e_dx_neg         zero
						be   e_Check_MLL&LR    zero             zero
// Checking for king
e_Check_King      bne  e_start_ai      e_Own_Piece      e_Red_King
						add  e_dx_pos          e_x              one
						sub  e_dx_neg          e_x              one
						add  e_dy_pos          e_y              one
						sub  e_dy_neg          e_y              one

e_Check_LeftB     be   e_Check_LowB1     e_dx_neg           zero
e_Check_rightB    be   e_Check_LowB2     e_dx_pos           nine
e_Check_LowB      be   e_Check_MLL&LR    e_dy_neg           zero
e_Check_UpB       be   e_Check_MUL&UR    e_dy_pos           nine
                  be   e_Check_all       zero               zero
e_Check_LowB1     be   e_Check_OMUR      e_dy_pos           nine
e_Check_UpB1      be   e_Check_OMLL      e_dy_pos           zero
						be   e_Check_MUR&LR    zero               zero
e_Check_LowB2     be   e_Check_OMUL      e_dy_pos           nine
e_Check_UpB2      be   e_Check_OMLR      e_dy_pos           zero
						be   e_Check_MUL&LL    zero               zero  

////////////////////////////////////////////////////////////
// Check lower left and lower right
// get pieces
e_Check_MLL&LR    call e_get_piece_LL    e_ret_get_piece_LL
						call e_get_piece_LR    e_ret_get_piece_LR
// Checking both caputure ways first
e_Chk_Cap_LL1     blt  e_Chk_Cap_LR1     e_Piece_LL         one
						call e_Check_Cap_LL    e_ret_ch_cap_LL
e_Chk_Cap_LR1     blt  e_sort1   	     e_Piece_LR         one
						call e_Check_Cap_LR    e_ret_ch_cap_LR

// sorts capture results
e_sort1		      be   e_Check_Cap_both1 e_Result_Check_LL  one
						be   e_Cap_LR          e_Result_Check_LR  one
						be   e_Check_MLL1      zero               zero
e_Check_Cap_both1 be   e_Cap_LL&LR       e_Result_Check_LR  one  
						be   e_Cap_LL          zero               zero

// Check for moves
e_Check_MLL1      be   e_Check_MB_LL&LR  e_Piece_LL         zero
e_Check_MLR1      be   e_Move_LR         e_Piece_LR         zero
						be   e_start_ai      zero               zero
e_Check_MB_LL&LR  be   e_Move_LL&LR      e_Piece_LR         zero
						be   e_Move_LL         zero               zero
// Check when only moves are upper left and lower left
e_Check_MUL&LL    call e_get_piece_UL    e_ret_get_piece_UL
						call e_get_piece_LL    e_ret_get_piece_LL
// Checking both caputure ways first
e_Chk_Cap_UL1     blt  e_Chk_Cap_LL2     e_Piece_UL          one
 						call e_Check_Cap_UL    e_ret_ch_cap_UL
e_Chk_Cap_LL2     blt  e_sort2    	     e_Piece_LL          one
						call e_Check_Cap_LL    e_ret_ch_cap_LL

// sorts capture results
e_sort2		      be   e_Check_Cap_both2 e_Result_Check_UL   one
						be   e_Cap_LL          e_Result_Check_LL   one
						be   e_Check_MUL1      zero                zero
e_Check_Cap_both2 be   e_Cap_LL&UL       e_Result_Check_LL   one  
						be   e_Cap_UL          zero                zero

// Check for moves
e_Check_MUL1      be   e_Check_MB_UL&LL  e_Piece_UL          zero
e_Check_MLL2      be   e_Move_LL         e_Piece_LL          zero
						be   e_start_ai      zero                zero
e_Check_MB_UL&LL  be   e_Move_LL&UL      e_Piece_LL          zero
						be   e_Move_UL         zero                zero
// Check when only moves are upper right and lower right
e_Check_MUR&LR    call e_get_piece_UR    e_ret_get_piece_UR
						call e_get_piece_LR    e_ret_get_piece_LR
// Checking both caputure ways first
e_Chk_Cap_UR1     blt  e_Chk_Cap_LR2     e_Piece_UR          one
						call e_Check_Cap_UR    e_ret_ch_cap_UR
e_Chk_Cap_LR2     blt  e_sort3    	     e_Piece_LR          one
						call e_Check_Cap_LR    e_ret_ch_cap_LR

// sorts capture results
e_sort3		      be   e_Check_Cap_both3 e_Result_Check_UR   one
						be   e_Cap_LR          e_Result_Check_LR   one
						be   e_Check_MUR1      zero                zero
e_Check_Cap_both3 be   e_Cap_LR&UR       e_Result_Check_LR   one  
						be   e_Cap_UR          zero                zero

// Check for moves
e_Check_MUR1      be   e_Check_MB_UR&LR  e_Piece_UR          zero
e_Check_MLR2      be   e_Move_LR         e_Piece_LR          zero
						be   e_start_ai      zero                zero
e_Check_MB_UR&LR  be   e_Move_LR&UR      e_Piece_LR          zero
						be   e_Move_UR         zero                zero
// Check when only moves are upper left and upper right
e_Check_MUL&UR    call e_get_piece_UL    e_ret_get_piece_UL
						call e_get_piece_UR    e_ret_get_piece_UR
// Checking both caputure ways first
e_Chk_Cap_UL2     blt  e_Chk_Cap_UR2     e_Piece_LL         one
						call e_Check_Cap_UL    e_ret_ch_cap_UL
e_Chk_Cap_UR2     blt  e_sort4    	     e_Piece_LR         one
						call e_Check_Cap_UR    e_ret_ch_cap_UR

// sorts capture results
e_sort4		      be   e_Check_Cap_both4 e_Result_Check_UL  one
						be   e_Cap_LR          e_Result_Check_UR  one
						be   e_Check_MUR1      zero               zero
e_Check_Cap_both4 be   e_Cap_UL&UR       e_Result_Check_UL  one  
						be   e_Cap_UR          zero               zero

// Check for moves
e_Check_MUL2      be   e_Check_MB_UL&UR  e_Piece_UL         zero
e_Check_MUR2      be   e_Move_UR         e_Piece_UR         zero
						be   e_start_ai      zero               zero
e_Check_MB_UL&UR  be   e_Move_UL&UR      e_Piece_UR         zero
						be   e_Move_UL         zero               zero
////////////////////////////////////////////////////////////////

// Check when all four moves are possible

e_Check_all   		call e_get_piece_LL       e_ret_get_piece_LL
		      		call e_get_piece_LR       e_ret_get_piece_LR
		      		call e_get_piece_UL       e_ret_get_piece_UL
		      		call e_get_piece_UR       e_ret_get_piece_UR

e_Chk_Cap_LL3  	blt  e_Chk_Cap_LR3        e_Piece_LL          one
						call e_Check_Cap_LL       e_ret_ch_cap_LL
e_Chk_Cap_LR3 		blt  e_Chk_Cap_UL3        e_Piece_LR          one
						call e_Check_Cap_LR       e_ret_ch_cap_LR
e_Chk_Cap_UL3  	blt  e_Chk_Cap_UR3        e_Piece_UL          one
						call e_Check_Cap_UL       e_ret_ch_cap_UL
e_Chk_Cap_UR3 		blt  e_sort5              e_Piece_UR          one
						call e_Check_Cap_UR       e_ret_ch_cap_UR
						
// sorts the checks
e_sort5 				add  e_NumCaps_LL&LR      e_Result_Check_LL   e_Result_Check_LR
						add  e_NumCaps_LR&UL      e_Result_Check_LR   e_Result_Check_UL
						add  e_NumCaps_LL&UL      e_Result_Check_LL   e_Result_Check_UL
						add  e_NumCaps_LR&UR      e_Result_Check_LR   e_Result_Check_UR
						add  e_NumCaps_UL&UR      e_Result_Check_UL   e_Result_Check_UR
						add  e_NumCaps_LL&UR      e_Result_Check_LL   e_Result_Check_UR
						add  e_NumCaps_LL&LR&UR   e_NumCaps_LL&LR     e_Result_Check_UR
						add  e_NumCaps_LR&UL&UR   e_NumCaps_LR&UL     e_Result_Check_UR
						add  e_NumCaps_LL&UL&UR   e_NumCaps_LL&UL     e_Result_Check_UR
						add  e_NumCaps_LL&LR&UL   e_NumCaps_LL&LR     e_Result_Check_UL
						add  e_NumCaps            e_NumCaps_LL&LR     e_NumCaps_UL&UR
                
						be   e_Cap_all            e_NumCaps           four
						be   e_Cap_LL&LR&UR       e_NumCaps_LL&LR&UR  three
						be   e_Cap_LR&UL&UR       e_NumCaps_LR&UL&UR  three
						be   e_Cap_LL&UL&UR       e_NumCaps_LL&UL&UR  three
						be   e_Cap_LL&LR&UL       e_NumCaps_LL&LR&UL  three
						be   e_Cap_LL&LR          e_NumCaps_LL&LR     two
						be   e_Cap_LR&UL          e_NumCaps_LR&UL     two
						be   e_Cap_LL&UL          e_NumCaps_LL&UL     two
						be   e_Cap_LR&UR          e_NumCaps_LR&UR     two
						be   e_Cap_UL&UR          e_NumCaps_UL&UR     two
						be   e_Cap_LL&UR          e_NumCaps_LL&UR     two
						be   e_Cap_LL             e_Result_Check_LL   one
						be   e_Cap_LR             e_Result_Check_LR   one
						be   e_Cap_UL             e_Result_Check_UL   one
						be   e_Cap_UR             e_Result_Check_UR   one

e_Pick_Move         be   e_Chk_Result_Mov_LL  e_Piece_LL          zero
e_Chk_Mov_LR		  be   e_Chk_Result_Mov_LR  e_Piece_LR          zero
e_Chk_Mov_UL        be   e_Chk_Result_Mov_UL  e_Piece_UL          zero
e_Chk_Mov_UR        be   e_Chk_Result_Mov_UR  e_Piece_UR          zero
						  be   e_sort6              zero              zero
e_Chk_Result_Mov_LL cp   e_Result_Mov_LL      one
						  be   e_Chk_Mov_LR         zero              zero
e_Chk_Result_Mov_LR cp   e_Result_Mov_LR      one
						  be   e_Chk_Mov_UL         zero              zero
e_Chk_Result_Mov_UL cp   e_Result_Mov_UL      one
						  be   e_Chk_Mov_UR         zero              zero
e_Chk_Result_Mov_UR cp   e_Result_Mov_UR      one 

e_sort6				add  e_NumMovs_LL&LR      e_Result_Mov_LL     e_Result_Mov_LR
						add  e_NumMovs_LR&UL      e_Result_Mov_LR     e_Result_Mov_UL
						add  e_NumMovs_LL&UL      e_Result_Mov_LL     e_Result_Mov_UL
						add  e_NumMovs_LR&UR      e_Result_Mov_LR     e_Result_Mov_UR
						add  e_NumMovs_UL&UR      e_Result_Mov_UL     e_Result_Mov_UR
						add  e_NumMovs_LL&UR      e_Result_Mov_LL     e_Result_Mov_UR
						add  e_NumMovs_LL&LR&UR   e_NumCaps_LL&LR     e_Result_Check_UR
						add  e_NumMovs_LR&UL&UR   e_NumCaps_LR&UL     e_Result_Check_UR
						add  e_NumMovs_LL&UL&UR   e_NumCaps_LL&UL     e_Result_Check_UR
						add  e_NumMovs_LL&LR&UL   e_NumCaps_LL&LR     e_Result_Check_UL
						add  e_NumMovs            e_NumMovs_LL&LR     e_NumMovs_UL&UR

						be   e_Move_all           e_NumMovs           four
						be   e_Move_LL&LR&UR      e_NumMovs_LL&LR&UR  three
						be   e_Move_LR&UL&UR      e_NumMovs_LR&UL&UR  three
						be   e_Move_LL&UL&UR      e_NumMovs_LL&UL&UR  three
						be   e_Move_LL&LR&UL      e_NumMovs_LL&LR&UL  three
						be   e_Move_LL&LR         e_NumMovs_LL&LR     two
						be   e_Move_LR&UL         e_NumMovs_LR&UL     two
						be   e_Move_LL&UL         e_NumMovs_LL&UL     two
						be   e_Move_LR&UR         e_NumMovs_LR&UR     two
						be   e_Move_UL&UR         e_NumMovs_UL&UR     two
						be   e_Move_LL&UR         e_NumMovs_LL&UR     two
						be   e_Move_LL            e_Result_Mov_LL     one
						be   e_Move_LR            e_Result_Mov_LR     one
						be   e_Move_UL            e_Result_Mov_UL     one
						be   e_Move_UR            e_Result_Mov_UR     one 
						be   e_start_ai         zero              zero
//////////////////////////////////////////////////////////////////
// Retrieve Piece_LL
e_get_piece_LL	   cp   calc_pos_x         e_dx_neg
                  cp   calc_pos_y         e_dy_pos
                  call calc_pos           calc_pos_retvar
		            cpfa e_Piece_LL           board             calc_pos_end
                  ret  e_ret_get_piece_LL

// Retrieve Piece_LR  
e_get_piece_LR	   cp   calc_pos_x         e_dx_pos
                  cp   calc_pos_y         e_dy_pos
                  call calc_pos           calc_pos_retvar
						cpfa e_Piece_LR         board             calc_pos_end
						ret  e_ret_get_piece_LR

// Retrieve Piece_UL
e_get_piece_UL	   cp   calc_pos_x         e_dx_neg
                  cp   calc_pos_y         e_dy_neg
                  call calc_pos           calc_pos_retvar
		  				cpfa e_Piece_UL           board             calc_pos_end
		  				ret  e_ret_get_piece_UL

// Retrieve Piece_UR
e_get_piece_UR	   cp   calc_pos_x         e_dx_pos
                  cp   calc_pos_y         e_dy_neg
                  call calc_pos           calc_pos_retvar
		  				cpfa e_Piece_UR           board             calc_pos_end
		  				ret  e_ret_get_piece_UR

// Retrieve Piece_LLL
e_get_piece_LLL	cp   calc_pos_x         e_dx_neg_neg
                  cp   calc_pos_y         e_dy_pos_pos
                  call calc_pos           calc_pos_retvar
		  				cpfa e_Piece_LLL          board             calc_pos_end
		  				ret  e_ret_get_piece_LLL

//Retreive Piece_LLR
e_get_piece_LLR	cp   calc_pos_x         e_dx_pos_pos
                  cp   calc_pos_y         e_dy_pos_pos
                  call calc_pos           calc_pos_retvar
		  				cpfa e_Piece_LLR          board             calc_pos_end
		  				ret  e_ret_get_piece_LLR

// Retrieve Piece_UUL
e_get_piece_UUL   cp   calc_pos_x         e_dx_neg_neg
                  cp   calc_pos_y         e_dy_neg_neg
                  call calc_pos           calc_pos_retvar
		  				cpfa e_Piece_UUL          board             calc_pos_end
		  				ret  e_ret_get_piece_UUL

// Retrieve Piece_UUR
e_get_piece_UUR   cp   calc_pos_x          e_dx_pos_pos
						cp   calc_pos_y          e_dy_neg_neg
						call calc_pos            calc_pos_retvar
						cpfa e_Piece_UUR           board             calc_pos_end
						ret  e_ret_get_piece_UUR
///////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// Checking for Caputre
// Checking for capture for the lower left
e_Check_Cap_LL    sub  e_dx_neg_neg         e_dx_neg             one
						add  e_dy_pos_pos         e_dy_pos             one
						be   e_End_chk_LL         e_dx_neg             zero
                  be   e_End_chk_LL         e_dy_pos             zero
						call e_get_piece_LLL      e_ret_get_piece_LLL
						be   e_Check_Result_LL    e_Piece_LLL          zero
						ret  e_ret_ch_cap_LL
e_Check_Result_LL cp   e_Result_Check_LL one
e_End_chk_LL		ret  e_ret_ch_cap_LL

// Checking for capture for the lower right
e_Check_Cap_LR    add  e_dx_pos_pos        e_dx_pos              one
						add  e_dy_pos_pos        e_dy_pos              one
						be   e_End_chk_LR        e_dx_pos_pos          nine
						be   e_End_chk_LR        e_dy_pos_pos          nine
						call e_get_piece_LLR     e_ret_get_piece_LLR     
						be   e_Check_Result_LR   e_Piece_LLR           zero
						ret  e_ret_ch_cap_LR
e_Check_Result_LR cp   e_Result_Check_LR one
e_End_chk_LR		ret  e_ret_ch_cap_LR 

// Checking for capture for the upper left
e_Check_Cap_UL    sub  e_dx_neg_neg        e_dx_neg            one
						sub  e_dy_neg_neg        e_dy_neg            one
						be   e_End_chk_UL        e_dx_neg_neg        zero
                  be   e_End_chk_UL        e_dy_neg_neg        zero
						call e_get_piece_UUL     e_ret_get_piece_UUL
						be   e_Check_Result_UL   e_Piece_UUL         zero
						ret  e_ret_ch_cap_UL
e_Check_Result_UL cp   e_Result_Check_UL  one
e_End_chk_UL		ret  e_ret_ch_cap_UL

// Checking for capture for the upper right
e_Check_Cap_UR    add  e_dx_pos_pos       e_dx_pos            one
						sub  e_dy_neg_neg       e_dy_neg            one
						be   e_End_chk_UR       e_dx_pos_pos        nine
                  be   e_End_chk_UR       e_dy_neg_neg        zero
						call e_get_piece_UUR    e_ret_get_piece_UUR
						be   e_Check_Result_UR  e_Piece_UUR         zero
						ret  e_ret_ch_cap_UR
e_Check_Result_UR cp   e_Result_Check_UR  one
e_End_chk_UR		ret  e_ret_ch_cap_UR
////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////
// Checks with pieces that only have one direction to move
// Check when only possible move is lower left
e_Check_OMLL      call e_get_piece_LL   e_ret_get_piece_LL
						be   e_Move_LL        e_Piece_LL          zero 
						sub  e_dx_neg_neg     e_dx_neg            one
						add  e_dy_pos_pos     e_dy_pos            one
						call e_get_piece_LLL  e_ret_get_piece_LLL              
						be   e_Cap_LL         e_Piece_LLL         zero
						be   e_start_ai      zero               zero

// Check when only possible move is lower right
e_Check_OMLR      call e_get_piece_LR   e_ret_get_piece_LR
						be   e_Move_LR        e_Piece_LR          zero 
						sub  e_dx_neg_neg     e_dx_neg            one
						add  e_dy_pos_pos     e_dy_pos            one
						call e_get_piece_LLR  e_ret_get_piece_LLR              
						be   e_Cap_LR         e_Piece_LLR         zero
						blt  e_start_ai     zero                zero

// Check when only possible move is Upper left
e_Check_OMUL      call e_get_piece_UL   e_ret_get_piece_UL
						be   e_Move_UL        e_Piece_UL          zero 
						add  e_dx_pos_pos     e_dx_pos            one
						sub  e_dy_neg_neg     e_dy_neg            one
						call e_get_piece_UUL  e_ret_get_piece_UUL            
						be   e_Cap_UL         e_Piece_UUL         zero
						blt  e_start_ai     zero                zero

// Check when only possible move is Upper right
e_Check_OMUR      call e_get_piece_UR   e_ret_get_piece_UR
						be   e_Move_UR        e_Piece_UR          zero 
						add  e_dx_pos_pos     e_dx_pos            one
						sub  e_dy_neg_neg     e_dy_neg            one
						call e_get_piece_UUR  e_ret_get_piece_UUR            
						be   e_Cap_UR         e_Piece_UUR         zero
						blt  e_start_ai     zero                zero
/////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
// Needs to pick direction since multiple directions can move
e_Move_LL&LR      call e_rand_gen2    e_ret_rand_gen2
						be   e_Move_LL      e_randnum        zero
						be   e_Move_LR      e_randnum        one

e_Move_LR&UL      call e_rand_gen2      e_ret_rand_gen2
						be   e_Move_LR        e_randnum        zero
						be   e_Move_UL        e_randnum        one

e_Move_LL&UL      call e_rand_gen2      e_ret_rand_gen2
						be   e_Move_UL        e_randnum        zero
						be   e_Move_LL        e_randnum        one

e_Move_LR&UR      call e_rand_gen2      e_ret_rand_gen2
						be   e_Move_UR        e_randnum        zero
						be   e_Move_LR        e_randnum        one

e_Move_UL&UR      call e_rand_gen2      e_ret_rand_gen2
						be   e_Move_UL        e_randnum        zero
						be   e_Move_UR        e_randnum        one

e_Move_LL&UR      call e_rand_gen2      e_ret_rand_gen2
						be   e_Move_LL        e_randnum        zero
						be   e_Move_UR        e_randnum        one

e_Move_LL&LR&UR   call e_rand_gen3      e_ret_rand_gen3   
						be   e_Move_LL        e_randnum        zero
						be   e_Move_LR        e_randnum        one
						be   e_Move_UR        e_randnum        two
 
e_Move_LR&UL&UR   call e_rand_gen3      e_ret_rand_gen3
						be   e_Move_LR        e_randnum        zero
						be   e_Move_UL        e_randnum        one
						be   e_Move_UR        e_randnum        two 

e_Move_LL&UL&UR   call e_rand_gen3      e_ret_rand_gen3
						be   e_Move_LL        e_randnum        zero
						be   e_Move_UL        e_randnum        one
						be   e_Move_UR        e_randnum        two 

e_Move_LL&LR&UL   call e_rand_gen3      e_ret_rand_gen3  
						be   e_Move_LL        e_randnum        zero
						be   e_Move_LR        e_randnum        one
						be   e_Move_UL        e_randnum        two 

e_Move_all	      call e_rand_gen4      e_ret_rand_gen4  
						be   e_Move_LL        e_randnum        zero
						be   e_Move_LR        e_randnum        one
						be   e_Move_UL        e_randnum        two
						be   e_Move_UR        e_randnum        three	
		
// Move Lower Left
e_Move_LL         cp   e_Piece_LL       e_Own_Piece
						cp   calc_pos_x       e_dx_neg
						cp   calc_pos_y       e_dy_pos
						call calc_pos         calc_pos_retvar
						cpta e_Piece_LL       board           calc_pos_end
						cp   e_Own_Piece      zero
						cp   calc_pos_x       e_x
						cp   calc_pos_y       e_y
						call calc_pos         calc_pos_retvar
						cpta e_Own_Piece      board           calc_pos_end 
						be   e_reset_results  zero            zero

// Move Lower Right
e_Move_LR         cp   e_Piece_LR       e_Own_Piece
						cp   calc_pos_x       e_dx_pos
						cp   calc_pos_y       e_dy_pos
						call calc_pos         calc_pos_retvar
						cpta e_Piece_LR       board           calc_pos_end
						cp   e_Own_Piece      zero
						cp   calc_pos_x       e_x
						cp   calc_pos_y       e_y
						call calc_pos         calc_pos_retvar
						cpta e_Own_Piece      board           calc_pos_end
						be   e_reset_results  zero            zero

// Move Upper Left
e_Move_UL         cp   e_Piece_UL       e_Own_Piece
						cp   calc_pos_x       e_dx_neg
						cp   calc_pos_y       e_dy_neg
						call calc_pos         calc_pos_retvar
						cpta e_Piece_UL       board           calc_pos_end
						cp   e_Own_Piece      zero
						cp   calc_pos_x       e_x
						cp   calc_pos_y       e_y
						call calc_pos         calc_pos_retvar
						cpta e_Own_Piece      board           calc_pos_end 
						be   e_reset_results  zero            zero

// Move Upper Right
e_Move_UR         cp   e_Piece_UR       e_Own_Piece
						cp   calc_pos_x       e_dx_pos
						cp   calc_pos_y       e_dy_neg
						call calc_pos         calc_pos_retvar
						cpta e_Piece_UR       board           calc_pos_end
						cp   e_Own_Piece      zero
						cp   calc_pos_x       e_x
						cp   calc_pos_y       e_y
						call calc_pos         calc_pos_retvar
						cpta e_Own_Piece      board           calc_pos_end
						be   e_reset_results  zero            zero
////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////
// Capturing pieces
// Needs to pick direction since multiple directions can move
e_Cap_LL&LR       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_LR        e_randnum        one

e_Cap_LR&UL       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_LR        e_randnum        zero
						be   e_Cap_UL        e_randnum        one

e_Cap_LL&UL       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_UL        e_randnum        one

e_Cap_LR&UR       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_UR        e_randnum        zero
						be   e_Cap_LR        e_randnum        one

e_Cap_UL&UR       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_UL        e_randnum        zero
						be   e_Cap_UR        e_randnum        one

e_Cap_LL&UR       call e_rand_gen2     e_ret_rand_gen2
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_UR        e_randnum        one

e_Cap_LL&LR&UR    call e_rand_gen2     e_ret_rand_gen3   
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_LR        e_randnum        one
						be   e_Cap_UR        e_randnum        two
 
e_Cap_LR&UL&UR    call e_rand_gen3     e_ret_rand_gen3
						be   e_Cap_LR        e_randnum        zero
						be   e_Cap_UL        e_randnum        one
						be   e_Cap_UR        e_randnum        two 

e_Cap_LL&UL&UR    call e_rand_gen3     e_ret_rand_gen3
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_UL        e_randnum        one
						be   e_Cap_UR        e_randnum        two 

e_Cap_LL&LR&UL    call e_rand_gen3     e_ret_rand_gen3  
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_LR        e_randnum        one
						be   e_Cap_UL        e_randnum        two 

e_Cap_all	      call e_rand_gen4     e_ret_rand_gen4  
						be   e_Cap_LL        e_randnum        zero
						be   e_Cap_LR        e_randnum        one
						be   e_Cap_UL        e_randnum        two
						be   e_Cap_UR        e_randnum        three

// Capture Lower Left
e_Cap_LL          cp   e_Piece_LLL     e_Own_Piece
						cp   calc_pos_x      e_dx_neg_neg
						cp   calc_pos_y      e_dy_pos_pos
						call calc_pos        calc_pos_retvar
						cpta e_Piece_LLL     board           calc_pos_end
						cp   e_Piece_LL      zero
						cp   calc_pos_x      e_dx_neg
						cp   calc_pos_y      e_dy_pos
						call calc_pos        calc_pos_retvar
						cpta e_Piece_LL      board           calc_pos_end
						cp   e_Own_Piece     zero
						cp   calc_pos_x      e_x
						cp   calc_pos_y      e_y
						call calc_pos        calc_pos_retvar
						cpta e_Own_Piece     board           calc_pos_end
						be   e_reset_results zero            zero

// Capture Lower Right
e_Cap_LR          cp   e_Piece_LLR     e_Own_Piece
						cp   calc_pos_x      e_dx_pos_pos 
						cp   calc_pos_y      e_dy_pos_pos           
						call calc_pos        calc_pos_retvar                   
						cpta e_Piece_LLR     board           calc_pos_end
						cp   e_Piece_LR      zero
						cp   calc_pos_x      e_dx_pos
						cp   calc_pos_y      e_dy_pos
						call calc_pos        calc_pos_retvar
						cpta e_Piece_LR      board           calc_pos_end
						cp   e_Own_Piece     zero
						cp   calc_pos_x      e_x
						cp   calc_pos_y      e_y
						call calc_pos        calc_pos_retvar
						cpta e_Own_Piece     board           calc_pos_end
						be   e_reset_results zero            zero

// Capture Upper Left
e_Cap_UL          cp   e_Piece_UUL     e_Own_Piece
						cp   calc_pos_x      e_dx_neg_neg
						cp   calc_pos_y      e_dy_neg_neg
						call calc_pos        calc_pos_retvar
						cpta e_Piece_UUL     board           calc_pos_end
						cp   e_Piece_UL      zero
						cp   calc_pos_x      e_dx_neg
						cp   calc_pos_y      e_dy_neg
						call calc_pos        calc_pos_retvar
						cpta e_Piece_UL      board           calc_pos_end
						cp   e_Own_Piece     zero
						cp   calc_pos_x      e_x
						cp   calc_pos_y      e_y
						call calc_pos        calc_pos_retvar
						cpta e_Own_Piece     board           calc_pos_end
						be   e_reset_results zero            zero

// Capture Upper Right
e_Cap_UR          cp   e_Piece_UUR     e_Own_Piece
						cp   calc_pos_x      e_dx_pos_pos
						cp   calc_pos_y      e_dy_neg_neg
						call calc_pos        calc_pos_retvar                 
						cpta e_Piece_UUR     board           calc_pos_end
						cp   e_Piece_UR      zero
						cp   calc_pos_x      e_dx_pos
						cp   calc_pos_y      e_dy_neg
						call calc_pos        calc_pos_retvar
						cpta e_Piece_UR      board           calc_pos_end
						cp   e_Own_Piece     zero
						cp   calc_pos_x      e_x
						cp   calc_pos_y      e_y
						call calc_pos        calc_pos_retvar
						cpta e_Own_Piece     board           calc_pos_end
						be   e_reset_results zero            zero
//////////////////////////////////////////////////////////////////	
e_rand_gen2       call e_rand_num_gen    e_retvar_rand
						and  e_randnum         e_randnum         one
                  ret  e_ret_rand_gen2

e_rand_gen3       call e_rand_num_gen     e_retvar_rand        
						mult e_randnum        e_randnum         three
						div  e_randnum        e_randnum         thirtyone
                  ret  e_ret_rand_gen3

e_rand_gen4       call e_rand_num_gen     e_retvar_rand
						and  e_randnum        e_randnum         three
						ret  e_ret_rand_gen4
//////////////////////////////////////////////////////////////////
// Resetting the results and preparing for the start of next turn
e_reset_results  	cp    e_Result_Check_LL  zero
						cp    e_Result_Check_LR  zero
						cp    e_Result_Check_UL  zero
						cp    e_Result_Check_UR  zero
						cp    e_Result_Mov_LL    zero
						cp    e_Result_Mov_LR    zero
						cp    e_Result_Mov_UL    zero
						cp    e_Result_Mov_UR    zero
						cp    e_NumCaps_LL&LR    zero
						cp    e_NumCaps_LR&UL    zero
						cp    e_NumCaps_LL&UL    zero
						cp    e_NumCaps_LR&UR    zero           
						cp    e_NumCaps_UL&UR    zero
						cp    e_NumCaps_LL&UR    zero
						cp    e_NumCaps_LL&LR&UR zero
						cp    e_NumCaps_LR&UL&UR zero
						cp    e_NumCaps_LL&UL&UR zero
						cp    e_NumCaps_LL&LR&UL zero
						cp    e_NumCaps          zero
						cp    e_NumMovs_LL&LR    zero
						cp    e_NumMovs_LR&UL    zero
						cp    e_NumMovs_LL&UL    zero
						cp    e_NumMovs_LR&UR    zero           
						cp    e_NumMovs_UL&UR    zero
						cp    e_NumMovs_LL&UR    zero
						cp    e_NumMovs_LL&LR&UR zero
						cp    e_NumMovs_LR&UL&UR zero
						cp    e_NumMovs_LL&UL&UR zero
						cp    e_NumMovs_LL&LR&UL zero
						cp    e_NumMovs          zero
						cp    e_ai_on_e          zero
						ret   e_retvar
						//be    e_Check_start      zero        zero
// Data for thea actual AI
e_Red               .data -1
e_Red_King          .data -2
e_pos               .data 0
nine                .data 9
thirtyone           .data 31
e_ai_on_e           .data 1
e_retvar            .data 0
e_x                 .data 4
e_y                 .data 5
e_dx_pos            .data 0
e_dx_neg            .data 0
e_dy_pos            .data 0
e_dy_neg            .data 0
e_dx_pos_pos        .data 0
e_dx_neg_neg        .data 0
e_dy_pos_pos        .data 0
e_dy_neg_neg        .data 0
e_ret_get_piece_LL  .data 0
e_ret_get_piece_LR  .data 0
e_ret_get_piece_UL  .data 0
e_ret_get_piece_UR  .data 0
e_ret_get_piece_LLL .data 0
e_ret_get_piece_LLR .data 0
e_ret_get_piece_UUL .data 0
e_ret_get_piece_UUR .data 0
e_ret_ch_cap_LL     .data 0
e_ret_ch_cap_LR     .data 0
e_ret_ch_cap_UL     .data 0
e_ret_ch_cap_UR     .data 0
e_ret_rand_gen2     .data 0
e_ret_rand_gen3     .data 0
e_ret_rand_gen4     .data 0
e_Own_Piece         .data 0
e_Piece_LL          .data 0
e_Piece_LR          .data 0
e_Piece_UL          .data 0
e_Piece_UR          .data 0
e_Piece_LLL         .data 0
e_Piece_LLR         .data 0
e_Piece_UUL         .data 0
e_Piece_UUR         .data 0
e_Result_Check_LL   .data 0
e_adfdadf           .data -5
e_Result_Check_LR   .data 0
e_asdfasdf          .data -5
e_Result_Check_UL   .data 0
e_Result_Check_UR   .data 0
e_Result_Mov_LL     .data 0
e_Result_Mov_LR     .data 0
e_Result_Mov_UL     .data 0
e_Result_Mov_UR     .data 0
e_NumCaps_LL&LR     .data 0
e_NumCaps_LR&UL     .data 0
e_NumCaps_LL&UL     .data 0
e_NumCaps_LR&UR     .data 0           
e_NumCaps_UL&UR     .data 0
e_NumCaps_LL&UR     .data 0
e_NumCaps_LL&LR&UR  .data 0
e_NumCaps_LR&UL&UR  .data 0
e_NumCaps_LL&UL&UR  .data 0
e_NumCaps_LL&LR&UL  .data 0
e_NumCaps           .data 0
e_NumMovs_LL&LR     .data 0
e_NumMovs_LR&UL     .data 0
e_NumMovs_LL&UL     .data 0
e_NumMovs_LR&UR     .data 0           
e_NumMovs_UL&UR     .data 0
e_NumMovs_LL&UR     .data 0
e_NumMovs_LL&LR&UR  .data 0
e_NumMovs_LR&UL&UR  .data 0
e_NumMovs_LL&UL&UR  .data 0
e_NumMovs_LL&LR&UL  .data 0
e_NumMovs           .data 0