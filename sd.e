SDcard_check1 in   		80            SDcard_valid             // get valid
              bne  		SDcard_check1 SDcard_valid SDcard_num1 // check if valid is 1
              in   		82            SDcard_data			  // input data
              out  		81            SDcard_ack               // output ack
SDcard_check2 in  	 	80            SDcard_valid             // check valid again
              bne  		SDcard_check2 SDcard_valid SDcard_num0 // check valid is 0
              out  		81            SDcard_num0              // Set ack to 0
              ret  		SDcard_ptr                             // Return to top of test program

SDcard_num0   .data 0
SDcard_num1   .data 1
SDcard_data	  .data 0
SDcard_valid  .data 0
SDcard_ack    .data 1
SDcard_ptr    .data 0