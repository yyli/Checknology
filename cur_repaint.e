//Repaints the color under the old cursor
cur_repaint             cp          width               cur_l                                       //sets a temp width variable with the width of the bg that we want to paint
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