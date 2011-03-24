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
bg_draw_loop cp         vga_x1      w_i                                                             //copy w_i (width incrementor) into x1
                        cp          vga_y1              h_i                                         //copy h_i (height incrementor) into y1
                        mult        i                   width           h_i                         //mult h_i with i (array incrementor)
                        add         i                   i               w_i                         //add w_i to i
                        cpfa        vga_color_out       img             i                           //copy the color from array
                        call        vga_write_one       vga_return                                  //call write one pixel
                        be          bg_draw_setzero     w_i             width-                      //if width is maxwidth-1 then set_cur_for_write it to zero
                        add         w_i                 w_i             one                         //add one to w_i
                        call        bg_draw_loop        dump                                        //repaint_loop bg_draw_loop
//end draw background
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
main_loop               call        mouse_loop          mouse_holder
                        cp          deltax              mouse_deltax
                        cp          deltay              mouse_deltay   
//repaint old pos
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
chk_e                   cp          width               cur_l                                       //change temp width to cursor length
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
                        cp          vga_color_out       black
                        call        vga_write_blk       vga_return
                        call        main_loop           dump
//end paint mouse        
                        halt
xlow                    cp          x                   0
                        call        chk_y               dump
xhigh                   cp          x                   vga_max_x
                        call        chk_y               dump
ylow                    cp          y                   0
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
                        be          init_grab_loop      h_i             height-
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
       
bg_w                    .data       448
bg_h                    .data       30
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
black                   .data       0
zero                    .data       0
one                     .data       1
two                     .data       2
four                    .data       4
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

#include vga.e
#include mouse.e
#include image.e