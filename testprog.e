//initalize the board
                        cp          turnvar             zero
                        cp          ai_on_e             zero
                        cp          ai_on_m             zero      
//draw background
                        cp          vga_x1              zero                                        //copies zero into x1
                        cp          vga_y1              zero                                        //copies zero into y1
                        cp          vga_x2              vga_max_x                                   //copies xmax into x2
                        cp          vga_y2              vga_max_y                                   //copies ymax into y2
                        cp          vga_color_out       white                                       //copies white into the color out
                        call        vga_write_blk       vga_return                                  //calls the write block function, and set_cur_for_write the return variable
                        cp          width               bg_w                                        //sets a temp width variable with the width of the bg that we want to paint
                        cp          height              bg_h                                        //sets a temp height ...
                        sub         width-              width           one                         //subtract one from width store in width-
                        sub         height-             height          one                         //...               height ...     height-
bg_draw_loop            cp          vga_x1              w_i                                         //copy w_i (width incrementor) into x1
                        cp          vga_y1              h_i                                         //copy h_i (height incrementor) into y1
                        mult        i                   width           h_i                         //mult h_i with i (array incrementor)
                        add         i                   i               w_i                         //add w_i to i
                        call        SDcard_check1       SDcard_ptr
                        cp          vga_color_out       SDcard_data
                        call        vga_write_one       vga_return
                        be          bg_draw_setzero     w_i             width-                      //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        call        bg_draw_loop        dump                                        //repaint_loop bg_draw_loop
//end draw background

//draw initial original board
draw_first_opt          call        draw_pvp            draw_ai_retvar                              //clear option selector
draw_init_piece_i       cp          i                   zero                                        //resets i
                        cp          turnvar             zero                                        //resets turn
                        call        turn_draw_c         retvar                                      //clear the turn indicator     
                        call        chk_win_clear       chk_win_retvar                              //clears the winning area        
draw_init_piece         cpfa        location_x          board_pos_x     i
                        cpfa        location_y          board_pos_y     i
                        cpfa        piece               board_orig      i
                        cpta        piece               board           i
                        sub         dump                location_x      one
                        mult        vga_x1              dump            width_square
                        mult        vga_x2              location_x      width_square
                        sub         dump                location_y      one
                        mult        vga_y1              dump            width_square
                        mult        vga_y2              location_y      width_square
                        cp          w_i                 zero
                        cp          h_i                 zero
                        cp          start_draw_x        vga_x1
                        cp          start_draw_y        vga_y1
                        be          init_king_red       piece           negtwo
                        be          init_red            piece           negone
                        be          init_king_blk       piece           two
                        be          init_blk            piece           one
                        be          init_blank          piece           zero
draw_init_inc           add         i                   i               one
                        blt         draw_init_piece     i               thirtytwo
//end draw initial original board
//draw initial turn
                        cp          vga_x1              turn_r_x1
                        cp          vga_x2              turn_r_x2
                        cp          vga_y1              turn_r_y1
                        cp          vga_y2              turn_r_y2
                        cp          vga_color_out       three
                        call        vga_write_blk       vga_return
//end draw initial turn

//start save xold
init_grab_loop          cp          width               cur_l                                       //change temp width to cursor length
                        cp          height              cur_l                                       //...         height ...
                        sub         width-              width           one                         //width-1
                        sub         height-             height          one                         //height-1
                        cp          w_i                 zero                                        //reset w_i
                        cp          h_i                 zero                                        //reset h_i
init_grab_in_loop       add         pos_w_i             w_i             x                           //add xold to w_i to get pos_w_i (x pos incrementor)
                        add         pos_h_i             h_i             y                           //add yold to h_i to get pos_w_i (y pos incrementor)
                        sub         pos_w_i             pos_w_i         two                         //sub two from pos_w_i to get to the left side
                        sub         pos_h_i             pos_h_i         two                         //add two to pos_h_i to get top side
                        cp          vga_x1              pos_w_i                                     //cp pos into x1
                        cp          vga_y1              pos_h_i                                     //...
                        mult        i                   width           h_i
                        add         i                   i               w_i
                        call        vga_read            vga_return
                        cpta        vga_color_in        old             i                           //read color in to array old
                        be          init_grab_setzero   w_i             width-                      //check if zero
                        add         w_i                 w_i             one                         //add one
                        call        init_grab_in_loop   dump  
//end save xold

//////start looping here

main_loop               call        chk_win             chk_win_retvar
                        be          ai_mouse_skip       ai_on_e                 one
                        be          ai_mouse_skip       ai_on_m                 one
main_loop2              call        mouse_loop          mouse_holder
                        cp          deltax              mouse_deltax
                        cp          deltay              mouse_deltay   
                        cp          lclick              mouse_left
                        cp          rclick              mouse_right
main_loop_ai            be          ai_loop_e           ai_on_e         one
                        be          ai_loop_m           ai_on_m         one
no_ai                   be          turn_draw_r         turnvar         zero
                        bne         turn_draw_b         turnvar         zero
//start repaint old pos
turn_draw_end           cp          width               cur_l                                       //sets a temp width variable with the width of the bg that we want to paint
                        cp          height              cur_l                                       //sets a temp height ...
                        sub         width-              width           one                         //subtract one from width store in width-
                        sub         height-             height          one                         //...               height ...     height-
                        cp          w_i                 zero                                        //reset w_i
                        cp          h_i                 zero                                        //reset h_i
repaint_loop            add         pos_w_i             x               w_i                         //add xold to w_i to get pos_w_i (x pos incrementor)
                        add         pos_h_i             y               h_i                         //add yold to h_i to get pos_w_i (y pos incrementor)
                        sub         pos_w_i             pos_w_i         two                         //sub two from pos_w_i to get to the left side
                        sub         pos_h_i             pos_h_i         two                         //add two to pos_h_i to get top side
                        cp          vga_x1              pos_w_i                                     //cp pos into x1
                        cp          vga_y1              pos_h_i                                     //...
                        mult        i                   width           h_i
                        add         i                   i               w_i
                        cpfa        vga_color_out       old             i                           //read color in to array old
                        call        vga_write_one       vga_return
                        be          repaint_setzero     w_i             width-                      //check if zero
                        add         w_i                 w_i             one                         //add one
                        call        repaint_loop        dump
//end repaint old pos

//start save new
grab_loop               add         x                   x               deltax
                        add         y                   y               deltay
chk_x                   blt         xlow                x               zero
                        blt         xhigh               vga_max_x       x
chk_y                   blt         ylow                y               zero
                        blt         yhigh               vga_max_y       y
//check mouse clicks for selection and reset
chk_e                   be          cp_reset            rclick          one
                        bne         next                lclick          one
                        blt         menu_opts           board_w         x
                        blt         menu_opts           board_h         y
menu_opts_aft           blt         cp_first            selected        one
                        blt         cp_second           selected        two
                        be          cp_comp_move        two             selected
                        blt         cp_comp_move        two             selected
start_redraw            call        redraw              retvar
//end check select
next                    cp          width               cur_l                                       //change temp width to cursor length
                        cp          height              cur_l                                       //...         height ...
                        sub         width-              width           one                         //width-1
                        sub         height-             height          one                         //height-1
                        cp          w_i                 zero                                        //reset w_i
                        cp          h_i                 zero                                        //reset h_i
grab_inner_loop         add         pos_w_i             w_i             x                           //add xold to w_i to get pos_w_i (x pos incrementor)
                        add         pos_h_i             h_i             y                           //add yold to h_i to get pos_w_i (y pos incrementor)
                        sub         pos_w_i             pos_w_i         two                         //sub two from pos_w_i to get to the left side
                        sub         pos_h_i             pos_h_i         two                         //add two to pos_h_i to get top side
                        cp          vga_x1              pos_w_i                                     //cp pos into x1
                        cp          vga_y1              pos_h_i                                     //...
                        mult        i                   width           h_i
                        add         i                   i               w_i
                        call        vga_read            vga_return
                        cpta        vga_color_in        old             i                           //read color in to array old
                        be          grab_setzero        w_i             width-                      //check if zero
                        add         w_i                 w_i             one                         //add one
                        call        grab_inner_loop     dump  
//end save new
//paint mouse
set_cur_for_write       call        draw_cur_bound      retvar
                        cp          vga_x1              x1
                        cp          vga_x2              x2
                        cp          vga_y1              y1
                        cp          vga_y2              y2
                        cp          vga_color_out       cur_color
                        call        vga_write_blk       vga_return
//end paint mouse
                        call        main_loop           dump

//////end main loop
                        halt
xlow                    cp          x                   zero
                        call        chk_y               dump
xhigh                   cp          x                   vga_max_x
                        call        chk_y               dump
ylow                    cp          y                   zero
                        call        chk_e               dump
yhigh                   cp          y                   vga_max_y
                        call        chk_e               dump
draw_cur_bound          sub         x1                  x               side_2
                        add         x2                  x               side_2
                        sub         y1                  y               side_2
                        add         y2                  y               side_2
                        ret         retvar      
//sets w_i to zero or end bg_draw_loop        
bg_draw_setzero         cp          w_i                 zero
                        be          draw_first_opt      h_i             height-
                        add         h_i                 h_i             one
                        call        bg_draw_loop        dump
//sets w_i to zero or end grab_inner_loop        
grab_setzero            cp          w_i                 zero
                        be          set_cur_for_write   h_i             height-
                        add         h_i                 h_i             one
                        call        grab_inner_loop     dump
//sets w_i to zero or end init_grab_in_loop        
init_grab_setzero       cp          w_i                 zero
                        be          main_loop           h_i             height-
                        add         h_i                 h_i             one
                        call        init_grab_in_loop   dump
//sets w_i to zero or end repaint_loop        
repaint_setzero         cp          w_i                 zero
                        be          grab_loop           h_i             height-
                        add         h_i                 h_i             one
                        call        repaint_loop        dump

//draw selection
redraw                  blt         end_selection       board_w         select_x
                        blt         end_selection       board_h         select_y
//check which square it is in
                        call        start_check_x       retvar1
                        cp          chkvalidsq_p        location_x
                        cp          chkvalidsq_q        location_y
                        call        chkvalidsq          chkvalidsq_retvar
                        bne         end_selection       chkvalidsq_end      one
//case 1
                        sub         dump                location_x      one
                        mult        dump                dump            width_square
                        cp          vga_x1              dump
                        mult        dump                location_x      width_square
                        cp          vga_x2              dump
                        sub         dump                location_y      one
                        mult        dump                dump            width_square
                        cp          vga_y1              dump
                        add         dump                dump            three
                        cp          vga_y2              dump
                        cp          vga_color_out       select_color
                        call        vga_write_blk       vga_return
//case 2
                        sub         dump                location_x      one
                        mult        dump                dump            width_square
                        cp          vga_x1              dump
                        mult        dump                location_x      width_square
                        cp          vga_x2              dump
                        mult        dump                location_y      width_square
                        sub         dump                dump            three
                        cp          vga_y1              dump
                        mult        dump                location_y      width_square
                        cp          vga_y2              dump
                        cp          vga_color_out       select_color
                        call        vga_write_blk       vga_return
//case 3
                        sub         dump                location_x      one
                        mult        dump                dump            width_square
                        cp          vga_x1              dump
                        add         dump                dump            three
                        cp          vga_x2              dump
                        sub         dump                location_y      one
                        mult        dump                dump            width_square
                        cp          vga_y1              dump
                        mult        dump                location_y      width_square
                        cp          vga_y2              dump
                        cp          vga_color_out       select_color
                        call        vga_write_blk       vga_return
//case 4
                        mult        dump                location_x      width_square
                        cp          vga_x2              dump
                        sub         dump                dump            three
                        cp          vga_x1              dump
                        sub         dump                location_y      one
                        mult        dump                dump            width_square
                        cp          vga_y1              dump
                        mult        dump                location_y      width_square
                        cp          vga_y2              dump
                        cp          vga_color_out       select_color
                        call        vga_write_blk       vga_return
                        add         selected            selected        one
end_selection           ret         retvar
//end draw selection

//check location
start_check_x           mult        dump                width_square    four
                        blt         board_four          select_x               dump
                        mult        dump                width_square    six
                        blt         board_six           select_x               dump
                        mult        dump                width_square    seven
                        blt         board_seven         select_x               dump
                        cp          location_x          eight         
check_location_endx     be          start_check_y       zero            zero
board_four              mult        dump                width_square    two
                        blt         board_two           select_x               dump
                        mult        dump                width_square    three
                        blt         board_three         select_x               dump
                        cp          location_x          four
                        be          check_location_endx zero            zero
board_six               mult        dump                width_square    five
                        blt         board_five          select_x               dump
                        cp          location_x          six
                        be          check_location_endx zero            zero
board_seven             cp          location_x          seven
                        be          check_location_endx zero            zero
board_two               blt         board_one           select_x               width_square
                        cp          location_x          two
                        be          check_location_endx zero            zero
board_three             cp          location_x          three
                        be          check_location_endx zero            zero
board_one               cp          location_x          one
                        be          check_location_endx zero            zero
board_five              cp          location_x          five
                        be          check_location_endx zero            zero
start_check_y           mult        dump                width_square    four
                        blt         board_four_y        select_y               dump
                        mult        dump                width_square    six
                        blt         board_six_y         select_y               dump
                        mult        dump                width_square    seven
                        blt         board_seven_y       select_y               dump
                        cp          location_y          eight         
check_location_endy     ret         retvar1
board_four_y            mult        dump                width_square    two
                        blt         board_two_y         select_y               dump
                        mult        dump                width_square    three
                        blt         board_three_y       select_y               dump
                        cp          location_y          four
                        be          check_location_endy zero            zero
board_six_y             mult        dump                width_square    five
                        blt         board_five_y        select_y               dump
                        cp          location_y          six
                        be          check_location_endy zero            zero
board_seven_y           cp          location_y          seven
                        be          check_location_endy zero            zero
board_two_y             blt         board_one_y         select_y               width_square
                        cp          location_y          two
                        be          check_location_endy zero            zero
board_three_y           cp          location_y          three
                        be          check_location_endy zero            zero
board_one_y             cp          location_y          one
                        be          check_location_endy zero            zero
board_five_y            cp          location_y          five
                        be          check_location_endy zero            zero
//end check location

//only two can be selected
cp_first                cp          select_x1           x
                        cp          select_y1           y
                        cp          select_x            x
                        cp          select_y            y
                        cp          select_color        cur_color  
                        be          start_redraw        zero            zero                      
cp_second               cp          select_x2           x
                        cp          select_y2           y
                        cp          select_x            x
                        cp          select_y            y
                        cp          select_color        cur_color
                        be          start_redraw        zero            zero         
cp_reset                blt         next                selected        one
                        blt         cp_reset2           selected        two
                        cp          selected            negone
                        cp          select_x            select_x2
                        cp          select_y            select_y2
                        cp          select_color        three
                        call        redraw              retvar                      
cp_reset2               cp          selected            negone
                        cp          select_x            select_x1
                        cp          select_y            select_y1
                        cp          select_color        three
                        be          start_redraw        zero            zero   
cp_comp_move            cp          select_x            select_x1
                        cp          select_y            select_y1
                        call        start_check_x       retvar1
                        cp          calc_pos_x          location_x
                        cp          calc_pos_y          location_y
                        cp          chk_vld_mv_x1       location_x
                        cp          chk_vld_mv_y1       location_y
                        call        calc_pos            calc_pos_retvar 
                        cp          tpiece_pos1         calc_pos_end
                        cp          select_x            select_x2
                        cp          select_y            select_y2
                        call        start_check_x       retvar1
                        cp          calc_pos_x          location_x
                        cp          calc_pos_y          location_y
                        cp          chk_vld_mv_x2       location_x
                        cp          chk_vld_mv_y2       location_y
                        call        calc_pos            calc_pos_retvar 
                        cp          tpiece_pos2         calc_pos_end     
                        cpfa        tpiece              board           tpiece_pos1
                        cp          chk_vld_mv_piece    tpiece
                        call        chk_vld_mv          chk_vld_mv_retvar
                        bne         pre_draw_piece      chk_vld_mv_vld  one
                        not         turnvar             turnvar
                        cpta        zero                board           tpiece_pos1
                        cpta        tpiece              board           tpiece_pos2
                        bne         chk_king            chk_vld_mv_mid  one
                        cpta        zero                board           chk_vld_mv_midloc
chk_king                bne         chk_king_blk        chk_vld_mv_king negone
                        cpta        negtwo              board           tpiece_pos2
chk_king_blk            bne         pre_draw_piece      chk_vld_mv_king one
                        cpta        two                 board           tpiece_pos2
pre_draw_piece          cp          i                   zero                                        //resets i         
draw_piece              cpfa        location_x          board_pos_x     i
                        cpfa        location_y          board_pos_y     i
                        cpfa        piece               board           i
                        sub         dump                location_x      one
                        mult        vga_x1              dump            width_square
                        mult        vga_x2              location_x      width_square
                        sub         dump                location_y      one
                        mult        vga_y1              dump            width_square
                        mult        vga_y2              location_y      width_square
                        cp          w_i                 zero
                        cp          h_i                 zero
                        cp          start_draw_x        vga_x1
                        cp          start_draw_y        vga_y1
                        be          init_king_red_p     piece           negtwo
                        be          init_red_p          piece           negone
                        be          init_king_blk_p     piece           two
                        be          init_blk_p          piece           one
                        be          init_blank_p        piece           zero
draw_piece_inc          add         i                   i               one
                        blt         draw_piece          i               thirtytwo
                        cp          selected            zero
                        be          next                zero            zero                             
//end selected

//choose which piece to draw in the inital draw
init_red                add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_red       p_i
                        call        vga_write_one       vga_return
                        be          red_setzero         w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_red            zero            zero
init_king_red           add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_red_k     p_i
                        call        vga_write_one       vga_return
                        be          redk_setzero        w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_king_red       zero            zero
init_blk                add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_blk       p_i
                        call        vga_write_one       vga_return
                        be          blk_setzero         w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_blk            zero            zero
init_king_blk           add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_blk_k     p_i
                        call        vga_write_one       vga_return
                        be          blkk_setzero        w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_king_blk       zero            zero
init_blank              cp          vga_color_out       three
                        call        vga_write_blk       vga_return
                        be          draw_init_inc       zero            zero
//end choose which piece to draw in the inital draw

//setzero functions for which piece to draw
redk_setzero            cp          w_i                 zero
                        be          draw_init_inc       h_i             width_square
                        add         h_i                 h_i             one
                        call        init_king_red       dump

red_setzero             cp          w_i                 zero
                        be          draw_init_inc       h_i             width_square
                        add         h_i                 h_i             one
                        call        init_red            dump

blk_setzero             cp          w_i                 zero
                        be          draw_init_inc       h_i             width_square
                        add         h_i                 h_i             one
                        call        init_blk            dump

blkk_setzero            cp          w_i                 zero
                        be          draw_init_inc       h_i             width_square
                        add         h_i                 h_i             one
                        call        init_king_blk       dump

red_p_setzero           cp          w_i                 zero
                        be          draw_piece_inc      h_i             width_square
                        add         h_i                 h_i             one
                        call        init_red_p          dump

redk_p_setzero          cp          w_i                 zero
                        be          draw_piece_inc      h_i             width_square
                        add         h_i                 h_i             one
                        call        init_king_red_p     dump

blk_p_setzero           cp          w_i                 zero
                        be          draw_piece_inc      h_i             width_square
                        add         h_i                 h_i             one
                        call        init_blk_p          dump

blkk_p_setzero          cp          w_i                 zero
                        be          draw_piece_inc      h_i             width_square
                        add         h_i                 h_i             one
                        call        init_king_blk_p     dump


//choose which piece to draw
init_red_p              add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_red       p_i
                        call        vga_write_one       vga_return
                        be          red_p_setzero       w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_red_p          zero            zero
init_king_red_p         add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_red_k     p_i
                        call        vga_write_one       vga_return
                        be          redk_p_setzero      w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_king_red_p     zero            zero
init_blk_p              add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_blk       p_i
                        call        vga_write_one       vga_return
                        be          blk_p_setzero       w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_blk_p          zero            zero
init_king_blk_p         add         vga_x1              w_i             start_draw_x                //copy w_i (width incrementor) into x1
                        add         vga_y1              h_i             start_draw_y                //copy h_i (height incrementor) into y1
                        mult        p_i                 width_square    h_i                         //mult h_i with i (array incrementor)
                        add         p_i                 p_i             w_i                         //add w_i to i
                        cpfa        vga_color_out       piece_blk_k     p_i
                        call        vga_write_one       vga_return
                        be          blkk_p_setzero      w_i             width_square               //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        be          init_king_blk_p     zero            zero
init_blank_p            cp          vga_color_out       three
                        call        vga_write_blk       vga_return
                        be          draw_piece_inc      zero            zero
//end choose which piece to draw

//draw who's turn it is
turn_draw_r             cp          vga_x1              turn_b_x1
                        cp          vga_x2              turn_b_x2
                        cp          vga_y1              turn_b_y1
                        cp          vga_y2              turn_b_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return
                        cp          vga_x1              turn_r_x1
                        cp          vga_x2              turn_r_x2
                        cp          vga_y1              turn_r_y1
                        cp          vga_y2              turn_r_y2
                        cp          vga_color_out       three
                        call        vga_write_blk       vga_return
                        be          turn_draw_end       zero            zero
turn_draw_b             cp          vga_x1              turn_r_x1
                        cp          vga_x2              turn_r_x2
                        cp          vga_y1              turn_r_y1
                        cp          vga_y2              turn_r_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return                        
                        cp          vga_x1              turn_b_x1
                        cp          vga_x2              turn_b_x2
                        cp          vga_y1              turn_b_y1
                        cp          vga_y2              turn_b_y2
                        cp          vga_color_out       three
                        call        vga_write_blk       vga_return
                        be          turn_draw_end       zero            zero
turn_draw_c             cp          vga_x1              turn_r_x1
                        cp          vga_x2              turn_r_x2
                        cp          vga_y1              turn_r_y1
                        cp          vga_y2              turn_r_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return                        
                        cp          vga_x1              turn_b_x1
                        cp          vga_x2              turn_b_x2
                        cp          vga_y1              turn_b_y1
                        cp          vga_y2              turn_b_y2
                        cp          vga_color_out       white
                        call        vga_write_blk       vga_return
                        ret         retvar

//end draw who's turn it is

//check if its outside the board or not
menu_opts               blt         menu_restart_game1  x                       rest_game_but_xmax
menu_pvp                blt         menu_pvp1           x                       pvp_but_xmax
menu_ai_e               blt         menu_ai_e1          x                       ai_e_but_xmax
menu_ai_m               blt         menu_ai_m1          x                       ai_m_but_xmax
menu_end                be          menu_opts_aft       zero                    zero     
    
menu_restart_game1      blt         menu_restart_game2  rest_game_but_xmin      x 
                        be          menu_ai_e           zero                    zero 
menu_restart_game2      blt         menu_restart_game3  y                       rest_game_but_ymax
                        be          menu_ai_e           zero                    zero 
menu_restart_game3      blt         menu_restart_game4  rest_game_but_ymin      y
                        be          menu_ai_e           zero                    zero
menu_restart_game4      be          draw_init_piece_i   zero                    zero 

menu_ai_e1              blt         menu_ai_e2          ai_e_but_xmin           x 
                        be          menu_ai_m           zero                    zero 
menu_ai_e2              blt         menu_ai_e3          y                       ai_e_but_ymax
                        be          menu_ai_m           zero                    zero 
menu_ai_e3              blt         menu_ai_e4          ai_e_but_ymin           y
                        be          menu_ai_m           zero                    zero 
menu_ai_e4              cp          ai_on_m             zero
                        cp          ai_on_e             one
                        call        draw_ai_e           draw_ai_retvar
                        be          draw_init_piece_i   zero                    zero

menu_ai_m1              blt         menu_ai_m2          ai_m_but_xmin           x 
                        be          menu_pvp            zero                    zero 
menu_ai_m2              blt         menu_ai_m3          y                       ai_m_but_ymax
                        be          menu_pvp            zero                    zero 
menu_ai_m3              blt         menu_ai_m4          ai_m_but_ymin           y
                        be          menu_pvp            zero                    zero 
menu_ai_m4              cp          ai_on_m             one
                        cp          ai_on_e             zero
                        call        draw_ai_m           draw_ai_retvar
                        be          draw_init_piece_i   zero                    zero
                
menu_pvp1               blt         menu_pvp2           pvp_but_xmin            x 
                        be          menu_end            zero                    zero 
menu_pvp2               blt         menu_pvp3           y                       pvp_but_ymax
                        be          menu_end            zero                    zero 
menu_pvp3               blt         menu_pvp4           pvp_but_ymin            y
                        be          menu_end            zero                    zero 
menu_pvp4               cp          ai_on_m             zero
                        cp          ai_on_e             zero
                        call        draw_pvp            draw_ai_retvar
                        be          draw_init_piece_i   zero                    zero   



//end checks if its outside the board

//runs AI
ai_loop_e               bne         no_ai               turnvar                 zero
                        //call ai here
                        call        e_start_ai          e_retvar
                        not         turnvar             turnvar
                        be          pre_draw_piece      zero                    zero
ai_loop_m               bne         no_ai               turnvar                 zero
                        //call ai here
                        not         turnvar             turnvar
                        be          pre_draw_piece      zero                    zero

//end runs AI
//check ai to skip mouse
ai_mouse_skip           be         main_loop_ai         turnvar                 zero
                        be         main_loop2           zero                    zero
//end check ai to skip mouse
                        // cp          vga_x2              ai_e_but_xmax
                        // cp          vga_x1              ai_e_but_xmin
                        // cp          vga_y2              ai_e_but_ymax
                        // cp          vga_y1              ai_e_but_ymin
                        // cp          vga_color_out       three
                        // call        vga_write_blk       vga_return
                        // halt

p_i                     .data       0
start_draw_x            .data       0
start_draw_y            .data       0
ai_on_e                 .data       1
ai_on_m                 .data       0
pvp_but_xmax            .data       586
pvp_but_xmin            .data       434
pvp_but_ymax            .data       67
pvp_but_ymin            .data       40
ai_m_but_xmax           .data       586
ai_m_but_xmin           .data       434
ai_m_but_ymax           .data       167
ai_m_but_ymin           .data       140
ai_e_but_xmax           .data       586
ai_e_but_xmin           .data       434
ai_e_but_ymax           .data       134
ai_e_but_ymin           .data       107
rest_game_but_xmax      .data       595
rest_game_but_xmin      .data       435
rest_game_but_ymax      .data       240
rest_game_but_ymin      .data       210
turn_b_x1               .data       330
turn_b_x2               .data       340
turn_b_y1               .data       300
turn_b_y2               .data       310
turn_r_x1               .data       330
turn_r_x2               .data       340
turn_r_y1               .data       10
turn_r_y2               .data       20
selected                .data       0
negtwo                  .data       -2
negone                  .data       -1
retvar2                 .data       0
select_x                .data       0
select_y                .data       0
select_x1               .data       0
select_y1               .data       0
select_x2               .data       0
select_y2               .data       0
select_color            .data       0
retvar1                 .data       0
location_x              .data       0
location_y              .data       0
width_square            .data       40
width_square-           .data       39
width_square2           .data       0
green                   .data       28
ten                     .data       5 
board_w                 .data       320
board_h                 .data       320
bg_w                    .data       640
bg_h                    .data       480
old                     .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
retvar                  .data       0
side_2                  .data       1
cur_l                   .data       5
dump                    .data       0
white                   .data       255
cur_color               .data       150
black                   .data       0
zero                    .data       0
one                     .data       1
two                     .data       2
three                   .data       3
four                    .data       4
five                    .data       5
six                     .data       6
seven                   .data       7
eight                   .data       8
fifteen                 .data       15
thirtytwo               .data       32
deltax                  .data       0
deltay                  .data       0
x                       .data       0
y                       .data       0
x1                      .data       0
x2                      .data       0
y1                      .data       0
y2                      .data       0
height                  .data       0
height-                 .data       0
width                   .data       0
width-                  .data       0
i                       .data       0
h_i                     .data       0
w_i                     .data       0
pos_h_i                 .data       0
pos_w_i                 .data       0
lclick                  .data       0
rclick                  .data       0
board_orig              .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       -1
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       1 
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       1
board_pos_x             .data       2
                        .data       4
                        .data       6
                        .data       8
                        .data       1
                        .data       3
                        .data       5
                        .data       7
                        .data       2
                        .data       4
                        .data       6
                        .data       8
                        .data       1
                        .data       3
                        .data       5
                        .data       7
                        .data       2
                        .data       4
                        .data       6
                        .data       8
                        .data       1
                        .data       3
                        .data       5
                        .data       7
                        .data       2
                        .data       4
                        .data       6
                        .data       8
                        .data       1
                        .data       3
                        .data       5
                        .data       7
board_pos_y             .data       1
                        .data       1
                        .data       1
                        .data       1
                        .data       2
                        .data       2
                        .data       2
                        .data       2
                        .data       3
                        .data       3
                        .data       3
                        .data       3
                        .data       4
                        .data       4
                        .data       4
                        .data       4
                        .data       5
                        .data       5
                        .data       5
                        .data       5
                        .data       6
                        .data       6
                        .data       6
                        .data       6
                        .data       7
                        .data       7
                        .data       7
                        .data       7
                        .data       8
                        .data       8
                        .data       8
                        .data       8
piece                   .data       0
tpiece_pos1             .data       0
tpiece_pos2             .data       0
tpiece                  .data       0
test                    .data       0
turnvar                 .data       0
board                   .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
                        .data       0
test1                   .data       0
#include vga.e
#include mouse.e
#include chkvalidsq.e
#include sd.e
#include calc_pos.e
#include draw_ai.e
#include chk_win.e
#include chk_vld_mv.e
#include pieces.e
#include Easy_AI.e
#include rand_num_gen.e