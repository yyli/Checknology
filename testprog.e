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
                        call        vga_write_one       vga_return                                  //call write one pixel
                        be          bg_draw_setzero     w_i             width-                      //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        call        bg_draw_loop        dump                                        //repaint_loop bg_draw_loop
//end draw background

//draw initial original board
draw_init_piece_i       cp          i                   zero                                        //resets i         
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
                        be          init_king_red       piece           negtwo
                        be          init_red            piece           negone
                        be          init_king_blk       piece           two
                        be          init_blk            piece           one
draw_init_inc           add         i                   i               one
                        blt         draw_init_piece     i               thirtytwo
//end draw initial original board

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

main_loop               call        mouse_loop          mouse_holder
                        cp          deltax              mouse_deltax
                        cp          deltay              mouse_deltay   
                        cp          lclick              mouse_left
                        cp          rclick              mouse_right
//start repaint old pos
                        cp          width               cur_l                                       //sets a temp width variable with the width of the bg that we want to paint
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
lol                     bne         next                lclick          one
                        blt         cp_first            selected        one
                        blt         cp_second           selected        two
                        be          cp_reset            two             selected
                        blt         cp_reset            two             selected
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
                        be          draw_init_piece_i   h_i             height-
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
//end selected

//choose which piece to draw
init_red                cp          vga_color_out       white
                        call        vga_write_blk       vga_return
                        be          draw_init_inc       zero            zero

init_king_red           cp          vga_color_out       white
                        call        vga_write_blk       vga_return
                        be          draw_init_inc       zero            zero

init_blk                cp          vga_color_out       zero
                        call        vga_write_blk       vga_return
                        be          draw_init_inc       zero            zero

init_king_blk           cp          vga_color_out       zero
                        call        vga_write_blk       vga_return
                        be          draw_init_inc       zero            zero
                            
//end choose which piece to draw

piece                   .data       0
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
cur_color               .data       252
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

#include vga.e
#include mouse.e
#include chkvalidsq.e
#include sd.e