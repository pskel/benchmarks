/*This is mechanically generated code*/

using namespace PSkel;
using namespace std;

namespace PSkel{
    __parallel__ void stencilKernel(Array2D<int> &input, Array2D<int> &output, Mask2D<int> &mask, int th,size_t i,size_t j){
        int cb = input(i,j) + th;
        int c_b= input(i,j) - th;

        if( input(i,j-3) > cb)
         if( input(i+1,j-3) > cb)
          if( input(i+2,j-2) > cb)
           if( input(i+3,j-1) > cb)
            if( input(i+3,j) > cb)
             if( input(i+3,j+1) > cb)
              if( input(i+2,j+2) > cb)
               if( input(i+1,j+3) > cb)
                if( input(i,j+3) > cb)
                 goto is_a_corner;
                else
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
               else if( input(i+1,j+3) < c_b)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else if( input(i-2,j-2) < c_b)
                 if( input(i,j+3) < c_b)
                  if( input(i-1,j+3) < c_b)
                   if( input(i-2,j+2) < c_b)
                    if( input(i-3,j+1) < c_b)
                     if( input(i-3,j) < c_b)
                      if( input(i-3,j-1) < c_b)
                       if( input(i-1,j-3) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else if( input(i+2,j+2) < c_b)
               if( input(i-1,j-3) > cb)
                if( input(i-3,j-1) > cb)
                 if( input(i-2,j-2) > cb)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else if( input(i-3,j-1) < c_b)
                 if( input(i+1,j+3) < c_b)
                  if( input(i,j+3) < c_b)
                   if( input(i-1,j+3) < c_b)
                    if( input(i-2,j+2) < c_b)
                     if( input(i-3,j+1) < c_b)
                      if( input(i-3,j) < c_b)
                       if( input(i-2,j-2) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                if( input(i+1,j+3) < c_b)
                 if( input(i,j+3) < c_b)
                  if( input(i-1,j+3) < c_b)
                   if( input(i-2,j+2) < c_b)
                    if( input(i-3,j+1) < c_b)
                     if( input(i-3,j) < c_b)
                      if( input(i-3,j-1) < c_b)
                       if( input(i-2,j-2) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else if( input(i-3,j-1) < c_b)
                if( input(i+1,j+3) < c_b)
                 if( input(i,j+3) < c_b)
                  if( input(i-1,j+3) < c_b)
                   if( input(i-2,j+2) < c_b)
                    if( input(i-3,j+1) < c_b)
                     if( input(i-3,j) < c_b)
                      if( input(i-2,j-2) < c_b)
                       if( input(i-1,j-3) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else if( input(i+3,j+1) < c_b)
              if( input(i-2,j-2) > cb)
               if( input(i-3,j) > cb)
                if( input(i-3,j-1) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       if( input(i-3,j+1) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else if( input(i-3,j) < c_b)
                if( input(i+2,j+2) < c_b)
                 if( input(i+1,j+3) < c_b)
                  if( input(i,j+3) < c_b)
                   if( input(i-1,j+3) < c_b)
                    if( input(i-2,j+2) < c_b)
                     if( input(i-3,j+1) < c_b)
                      if( input(i-3,j-1) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-2,j-2) < c_b)
               if( input(i+1,j+3) < c_b)
                if( input(i,j+3) < c_b)
                 if( input(i-1,j+3) < c_b)
                  if( input(i-2,j+2) < c_b)
                   if( input(i-3,j+1) < c_b)
                    if( input(i-3,j) < c_b)
                     if( input(i-3,j-1) < c_b)
                      if( input(i+2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       if( input(i-1,j-3) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               if( input(i+2,j+2) < c_b)
                if( input(i+1,j+3) < c_b)
                 if( input(i,j+3) < c_b)
                  if( input(i-1,j+3) < c_b)
                   if( input(i-2,j+2) < c_b)
                    if( input(i-3,j+1) < c_b)
                     if( input(i-3,j) < c_b)
                      if( input(i-3,j-1) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       if( input(i-3,j+1) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-3,j) < c_b)
               if( input(i+1,j+3) < c_b)
                if( input(i,j+3) < c_b)
                 if( input(i-1,j+3) < c_b)
                  if( input(i-2,j+2) < c_b)
                   if( input(i-3,j+1) < c_b)
                    if( input(i-3,j-1) < c_b)
                     if( input(i-2,j-2) < c_b)
                      if( input(i+2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       if( input(i-1,j-3) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else if( input(i+3,j) < c_b)
             if( input(i-3,j-1) > cb)
              if( input(i-3,j+1) > cb)
               if( input(i-3,j) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-3,j+1) < c_b)
               if( input(i+3,j+1) < c_b)
                if( input(i+2,j+2) < c_b)
                 if( input(i+1,j+3) < c_b)
                  if( input(i,j+3) < c_b)
                   if( input(i-1,j+3) < c_b)
                    if( input(i-2,j+2) < c_b)
                     if( input(i-3,j) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else if( input(i-3,j-1) < c_b)
              if( input(i+1,j+3) < c_b)
               if( input(i,j+3) < c_b)
                if( input(i-1,j+3) < c_b)
                 if( input(i-2,j+2) < c_b)
                  if( input(i-3,j+1) < c_b)
                   if( input(i-3,j) < c_b)
                    if( input(i+2,j+2) < c_b)
                     if( input(i+3,j+1) < c_b)
                      goto is_a_corner;
                     else
                      if( input(i-2,j-2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                    else
                     if( input(i-2,j-2) < c_b)
                      if( input(i-1,j-3) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              if( input(i+3,j+1) < c_b)
               if( input(i+2,j+2) < c_b)
                if( input(i+1,j+3) < c_b)
                 if( input(i,j+3) < c_b)
                  if( input(i-1,j+3) < c_b)
                   if( input(i-2,j+2) < c_b)
                    if( input(i-3,j+1) < c_b)
                     if( input(i-3,j) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      if( input(i-2,j+2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else if( input(i-3,j+1) < c_b)
              if( input(i+1,j+3) < c_b)
               if( input(i,j+3) < c_b)
                if( input(i-1,j+3) < c_b)
                 if( input(i-2,j+2) < c_b)
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    if( input(i+2,j+2) < c_b)
                     if( input(i+3,j+1) < c_b)
                      goto is_a_corner;
                     else
                      if( input(i-2,j-2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                    else
                     if( input(i-2,j-2) < c_b)
                      if( input(i-1,j-3) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
           else if( input(i+3,j-1) < c_b)
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else if( input(i-2,j+2) < c_b)
             if( input(i+1,j+3) < c_b)
              if( input(i,j+3) < c_b)
               if( input(i-1,j+3) < c_b)
                if( input(i-3,j+1) < c_b)
                 if( input(i+2,j+2) < c_b)
                  if( input(i+3,j+1) < c_b)
                   if( input(i+3,j) < c_b)
                    goto is_a_corner;
                   else
                    if( input(i-3,j) < c_b)
                     if( input(i-3,j-1) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j) < c_b)
                    if( input(i-3,j-1) < c_b)
                     if( input(i-2,j-2) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    if( input(i-2,j-2) < c_b)
                     if( input(i-1,j-3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     if( input(i-1,j+3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else if( input(i-2,j+2) < c_b)
             if( input(i+1,j+3) < c_b)
              if( input(i,j+3) < c_b)
               if( input(i-1,j+3) < c_b)
                if( input(i-3,j+1) < c_b)
                 if( input(i-3,j) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+3,j+1) < c_b)
                    if( input(i+3,j) < c_b)
                     goto is_a_corner;
                    else
                     if( input(i-3,j-1) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    if( input(i-3,j-1) < c_b)
                     if( input(i-2,j-2) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j-1) < c_b)
                    if( input(i-2,j-2) < c_b)
                     if( input(i-1,j-3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
          else if( input(i+2,j-2) < c_b)
           if( input(i-1,j+3) > cb)
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else if( input(i-1,j+3) < c_b)
            if( input(i+1,j+3) < c_b)
             if( input(i,j+3) < c_b)
              if( input(i-2,j+2) < c_b)
               if( input(i+2,j+2) < c_b)
                if( input(i+3,j+1) < c_b)
                 if( input(i+3,j) < c_b)
                  if( input(i+3,j-1) < c_b)
                   goto is_a_corner;
                  else
                   if( input(i-3,j+1) < c_b)
                    if( input(i-3,j) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j+1) < c_b)
                   if( input(i-3,j) < c_b)
                    if( input(i-3,j-1) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j+1) < c_b)
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    if( input(i-2,j-2) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-3,j+1) < c_b)
                 if( input(i-3,j) < c_b)
                  if( input(i-3,j-1) < c_b)
                   if( input(i-2,j-2) < c_b)
                    if( input(i-1,j-3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           if( input(i-1,j+3) > cb)
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    if( input(i,j+3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else if( input(i-1,j+3) < c_b)
            if( input(i+1,j+3) < c_b)
             if( input(i,j+3) < c_b)
              if( input(i-2,j+2) < c_b)
               if( input(i-3,j+1) < c_b)
                if( input(i+2,j+2) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+3,j) < c_b)
                   if( input(i+3,j-1) < c_b)
                    goto is_a_corner;
                   else
                    if( input(i-3,j) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j) < c_b)
                    if( input(i-3,j-1) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    if( input(i-2,j-2) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j) < c_b)
                  if( input(i-3,j-1) < c_b)
                   if( input(i-2,j-2) < c_b)
                    if( input(i-1,j-3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
         else if( input(i+1,j-3) < c_b)
          if( input(i,j+3) > cb)
           if( input(i-1,j+3) > cb)
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i+2,j-2) > cb)
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else if( input(i,j+3) < c_b)
           if( input(i+1,j+3) < c_b)
            if( input(i-1,j+3) < c_b)
             if( input(i+2,j+2) < c_b)
              if( input(i+3,j+1) < c_b)
               if( input(i+3,j) < c_b)
                if( input(i+3,j-1) < c_b)
                 if( input(i+2,j-2) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i-2,j+2) < c_b)
                   if( input(i-3,j+1) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-2,j+2) < c_b)
                  if( input(i-3,j+1) < c_b)
                   if( input(i-3,j) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-2,j+2) < c_b)
                 if( input(i-3,j+1) < c_b)
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-2,j+2) < c_b)
                if( input(i-3,j+1) < c_b)
                 if( input(i-3,j) < c_b)
                  if( input(i-3,j-1) < c_b)
                   if( input(i-2,j-2) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-2,j+2) < c_b)
               if( input(i-3,j+1) < c_b)
                if( input(i-3,j) < c_b)
                 if( input(i-3,j-1) < c_b)
                  if( input(i-2,j-2) < c_b)
                   if( input(i-1,j-3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
         else
          if( input(i,j+3) > cb)
           if( input(i-1,j+3) > cb)
            if( input(i-2,j+2) > cb)
             if( input(i-3,j+1) > cb)
              if( input(i-3,j) > cb)
               if( input(i-3,j-1) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i-1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i+2,j-2) > cb)
               if( input(i+3,j-1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+1,j+3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else if( input(i,j+3) < c_b)
           if( input(i+1,j+3) < c_b)
            if( input(i-1,j+3) < c_b)
             if( input(i-2,j+2) < c_b)
              if( input(i+2,j+2) < c_b)
               if( input(i+3,j+1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j-1) < c_b)
                  if( input(i+2,j-2) < c_b)
                   goto is_a_corner;
                  else
                   if( input(i-3,j+1) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j+1) < c_b)
                   if( input(i-3,j) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j+1) < c_b)
                  if( input(i-3,j) < c_b)
                   if( input(i-3,j-1) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-3,j+1) < c_b)
                 if( input(i-3,j) < c_b)
                  if( input(i-3,j-1) < c_b)
                   if( input(i-2,j-2) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-3,j+1) < c_b)
                if( input(i-3,j) < c_b)
                 if( input(i-3,j-1) < c_b)
                  if( input(i-2,j-2) < c_b)
                   if( input(i-1,j-3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
        else if( input(i,j-3) < c_b)
         if( input(i+1,j-3) > cb)
          if( input(i,j+3) > cb)
           if( input(i+1,j+3) > cb)
            if( input(i-1,j+3) > cb)
             if( input(i+2,j+2) > cb)
              if( input(i+3,j+1) > cb)
               if( input(i+3,j) > cb)
                if( input(i+3,j-1) > cb)
                 if( input(i+2,j-2) > cb)
                  goto is_a_corner;
                 else
                  if( input(i-2,j+2) > cb)
                   if( input(i-3,j+1) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-2,j+2) > cb)
                  if( input(i-3,j+1) > cb)
                   if( input(i-3,j) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-2,j+2) > cb)
                 if( input(i-3,j+1) > cb)
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-2,j+2) > cb)
                if( input(i-3,j+1) > cb)
                 if( input(i-3,j) > cb)
                  if( input(i-3,j-1) > cb)
                   if( input(i-2,j-2) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-2,j+2) > cb)
               if( input(i-3,j+1) > cb)
                if( input(i-3,j) > cb)
                 if( input(i-3,j-1) > cb)
                  if( input(i-2,j-2) > cb)
                   if( input(i-1,j-3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else if( input(i,j+3) < c_b)
           if( input(i-1,j+3) < c_b)
            if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i+2,j-2) < c_b)
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
         else if( input(i+1,j-3) < c_b)
          if( input(i+2,j-2) > cb)
           if( input(i-1,j+3) > cb)
            if( input(i+1,j+3) > cb)
             if( input(i,j+3) > cb)
              if( input(i-2,j+2) > cb)
               if( input(i+2,j+2) > cb)
                if( input(i+3,j+1) > cb)
                 if( input(i+3,j) > cb)
                  if( input(i+3,j-1) > cb)
                   goto is_a_corner;
                  else
                   if( input(i-3,j+1) > cb)
                    if( input(i-3,j) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j+1) > cb)
                   if( input(i-3,j) > cb)
                    if( input(i-3,j-1) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j+1) > cb)
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    if( input(i-2,j-2) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-3,j+1) > cb)
                 if( input(i-3,j) > cb)
                  if( input(i-3,j-1) > cb)
                   if( input(i-2,j-2) > cb)
                    if( input(i-1,j-3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else if( input(i-1,j+3) < c_b)
            if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else if( input(i+2,j-2) < c_b)
           if( input(i+3,j-1) > cb)
            if( input(i-2,j+2) > cb)
             if( input(i+1,j+3) > cb)
              if( input(i,j+3) > cb)
               if( input(i-1,j+3) > cb)
                if( input(i-3,j+1) > cb)
                 if( input(i+2,j+2) > cb)
                  if( input(i+3,j+1) > cb)
                   if( input(i+3,j) > cb)
                    goto is_a_corner;
                   else
                    if( input(i-3,j) > cb)
                     if( input(i-3,j-1) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j) > cb)
                    if( input(i-3,j-1) > cb)
                     if( input(i-2,j-2) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    if( input(i-2,j-2) > cb)
                     if( input(i-1,j-3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else if( input(i+3,j-1) < c_b)
            if( input(i+3,j) > cb)
             if( input(i-3,j-1) > cb)
              if( input(i+1,j+3) > cb)
               if( input(i,j+3) > cb)
                if( input(i-1,j+3) > cb)
                 if( input(i-2,j+2) > cb)
                  if( input(i-3,j+1) > cb)
                   if( input(i-3,j) > cb)
                    if( input(i+2,j+2) > cb)
                     if( input(i+3,j+1) > cb)
                      goto is_a_corner;
                     else
                      if( input(i-2,j-2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                    else
                     if( input(i-2,j-2) > cb)
                      if( input(i-1,j-3) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else if( input(i-3,j-1) < c_b)
              if( input(i-3,j+1) > cb)
               if( input(i+3,j+1) > cb)
                if( input(i+2,j+2) > cb)
                 if( input(i+1,j+3) > cb)
                  if( input(i,j+3) > cb)
                   if( input(i-1,j+3) > cb)
                    if( input(i-2,j+2) > cb)
                     if( input(i-3,j) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-3,j+1) < c_b)
               if( input(i-3,j) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              if( input(i+3,j+1) > cb)
               if( input(i+2,j+2) > cb)
                if( input(i+1,j+3) > cb)
                 if( input(i,j+3) > cb)
                  if( input(i-1,j+3) > cb)
                   if( input(i-2,j+2) > cb)
                    if( input(i-3,j+1) > cb)
                     if( input(i-3,j) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else if( input(i+3,j) < c_b)
             if( input(i+3,j+1) > cb)
              if( input(i-2,j-2) > cb)
               if( input(i+1,j+3) > cb)
                if( input(i,j+3) > cb)
                 if( input(i-1,j+3) > cb)
                  if( input(i-2,j+2) > cb)
                   if( input(i-3,j+1) > cb)
                    if( input(i-3,j) > cb)
                     if( input(i-3,j-1) > cb)
                      if( input(i+2,j+2) > cb)
                       goto is_a_corner;
                      else
                       if( input(i-1,j-3) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-2,j-2) < c_b)
               if( input(i-3,j) > cb)
                if( input(i+2,j+2) > cb)
                 if( input(i+1,j+3) > cb)
                  if( input(i,j+3) > cb)
                   if( input(i-1,j+3) > cb)
                    if( input(i-2,j+2) > cb)
                     if( input(i-3,j+1) > cb)
                      if( input(i-3,j-1) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else if( input(i-3,j) < c_b)
                if( input(i-3,j-1) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       if( input(i-3,j+1) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               if( input(i+2,j+2) > cb)
                if( input(i+1,j+3) > cb)
                 if( input(i,j+3) > cb)
                  if( input(i-1,j+3) > cb)
                   if( input(i-2,j+2) > cb)
                    if( input(i-3,j+1) > cb)
                     if( input(i-3,j) > cb)
                      if( input(i-3,j-1) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else if( input(i+3,j+1) < c_b)
              if( input(i+2,j+2) > cb)
               if( input(i-1,j-3) < c_b)
                if( input(i-3,j-1) > cb)
                 if( input(i+1,j+3) > cb)
                  if( input(i,j+3) > cb)
                   if( input(i-1,j+3) > cb)
                    if( input(i-2,j+2) > cb)
                     if( input(i-3,j+1) > cb)
                      if( input(i-3,j) > cb)
                       if( input(i-2,j-2) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else if( input(i-3,j-1) < c_b)
                 if( input(i-2,j-2) < c_b)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                if( input(i+1,j+3) > cb)
                 if( input(i,j+3) > cb)
                  if( input(i-1,j+3) > cb)
                   if( input(i-2,j+2) > cb)
                    if( input(i-3,j+1) > cb)
                     if( input(i-3,j) > cb)
                      if( input(i-3,j-1) > cb)
                       if( input(i-2,j-2) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else if( input(i+2,j+2) < c_b)
               if( input(i+1,j+3) > cb)
                if( input(i-2,j-2) > cb)
                 if( input(i,j+3) > cb)
                  if( input(i-1,j+3) > cb)
                   if( input(i-2,j+2) > cb)
                    if( input(i-3,j+1) > cb)
                     if( input(i-3,j) > cb)
                      if( input(i-3,j-1) > cb)
                       if( input(i-1,j-3) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else if( input(i+1,j+3) < c_b)
                if( input(i,j+3) < c_b)
                 goto is_a_corner;
                else
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-3,j-1) > cb)
                if( input(i+1,j+3) > cb)
                 if( input(i,j+3) > cb)
                  if( input(i-1,j+3) > cb)
                   if( input(i-2,j+2) > cb)
                    if( input(i-3,j+1) > cb)
                     if( input(i-3,j) > cb)
                      if( input(i-2,j-2) > cb)
                       if( input(i-1,j-3) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-3,j) > cb)
               if( input(i+1,j+3) > cb)
                if( input(i,j+3) > cb)
                 if( input(i-1,j+3) > cb)
                  if( input(i-2,j+2) > cb)
                   if( input(i-3,j+1) > cb)
                    if( input(i-3,j-1) > cb)
                     if( input(i-2,j-2) > cb)
                      if( input(i+2,j+2) > cb)
                       goto is_a_corner;
                      else
                       if( input(i-1,j-3) > cb)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       if( input(i-3,j+1) < c_b)
                        goto is_a_corner;
                       else
                        goto is_not_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             if( input(i-3,j+1) > cb)
              if( input(i+1,j+3) > cb)
               if( input(i,j+3) > cb)
                if( input(i-1,j+3) > cb)
                 if( input(i-2,j+2) > cb)
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    if( input(i+2,j+2) > cb)
                     if( input(i+3,j+1) > cb)
                      goto is_a_corner;
                     else
                      if( input(i-2,j-2) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                    else
                     if( input(i-2,j-2) > cb)
                      if( input(i-1,j-3) > cb)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      if( input(i-2,j+2) < c_b)
                       goto is_a_corner;
                      else
                       goto is_not_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
           else
            if( input(i-2,j+2) > cb)
             if( input(i+1,j+3) > cb)
              if( input(i,j+3) > cb)
               if( input(i-1,j+3) > cb)
                if( input(i-3,j+1) > cb)
                 if( input(i-3,j) > cb)
                  if( input(i+2,j+2) > cb)
                   if( input(i+3,j+1) > cb)
                    if( input(i+3,j) > cb)
                     goto is_a_corner;
                    else
                     if( input(i-3,j-1) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                   else
                    if( input(i-3,j-1) > cb)
                     if( input(i-2,j-2) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j-1) > cb)
                    if( input(i-2,j-2) > cb)
                     if( input(i-1,j-3) > cb)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     if( input(i-1,j+3) < c_b)
                      goto is_a_corner;
                     else
                      goto is_not_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
          else
           if( input(i-1,j+3) > cb)
            if( input(i+1,j+3) > cb)
             if( input(i,j+3) > cb)
              if( input(i-2,j+2) > cb)
               if( input(i-3,j+1) > cb)
                if( input(i+2,j+2) > cb)
                 if( input(i+3,j+1) > cb)
                  if( input(i+3,j) > cb)
                   if( input(i+3,j-1) > cb)
                    goto is_a_corner;
                   else
                    if( input(i-3,j) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                  else
                   if( input(i-3,j) > cb)
                    if( input(i-3,j-1) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    if( input(i-2,j-2) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j) > cb)
                  if( input(i-3,j-1) > cb)
                   if( input(i-2,j-2) > cb)
                    if( input(i-1,j-3) > cb)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else if( input(i-1,j+3) < c_b)
            if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    if( input(i,j+3) < c_b)
                     goto is_a_corner;
                    else
                     goto is_not_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
         else
          if( input(i,j+3) > cb)
           if( input(i+1,j+3) > cb)
            if( input(i-1,j+3) > cb)
             if( input(i-2,j+2) > cb)
              if( input(i+2,j+2) > cb)
               if( input(i+3,j+1) > cb)
                if( input(i+3,j) > cb)
                 if( input(i+3,j-1) > cb)
                  if( input(i+2,j-2) > cb)
                   goto is_a_corner;
                  else
                   if( input(i-3,j+1) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                 else
                  if( input(i-3,j+1) > cb)
                   if( input(i-3,j) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-3,j+1) > cb)
                  if( input(i-3,j) > cb)
                   if( input(i-3,j-1) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-3,j+1) > cb)
                 if( input(i-3,j) > cb)
                  if( input(i-3,j-1) > cb)
                   if( input(i-2,j-2) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-3,j+1) > cb)
                if( input(i-3,j) > cb)
                 if( input(i-3,j-1) > cb)
                  if( input(i-2,j-2) > cb)
                   if( input(i-1,j-3) > cb)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else if( input(i,j+3) < c_b)
           if( input(i-1,j+3) < c_b)
            if( input(i-2,j+2) < c_b)
             if( input(i-3,j+1) < c_b)
              if( input(i-3,j) < c_b)
               if( input(i-3,j-1) < c_b)
                if( input(i-2,j-2) < c_b)
                 if( input(i-1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i+2,j-2) < c_b)
               if( input(i+3,j-1) < c_b)
                if( input(i+3,j) < c_b)
                 if( input(i+3,j+1) < c_b)
                  if( input(i+2,j+2) < c_b)
                   if( input(i+1,j+3) < c_b)
                    goto is_a_corner;
                   else
                    goto is_not_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
        else
         if( input(i+1,j+3) > cb)
          if( input(i,j+3) > cb)
           if( input(i-1,j+3) > cb)
            if( input(i+2,j+2) > cb)
             if( input(i+3,j+1) > cb)
              if( input(i+3,j) > cb)
               if( input(i+3,j-1) > cb)
                if( input(i+2,j-2) > cb)
                 if( input(i+1,j-3) > cb)
                  goto is_a_corner;
                 else
                  if( input(i-2,j+2) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-2,j+2) > cb)
                  if( input(i-3,j+1) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-2,j+2) > cb)
                 if( input(i-3,j+1) > cb)
                  if( input(i-3,j) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-2,j+2) > cb)
                if( input(i-3,j+1) > cb)
                 if( input(i-3,j) > cb)
                  if( input(i-3,j-1) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-2,j+2) > cb)
               if( input(i-3,j+1) > cb)
                if( input(i-3,j) > cb)
                 if( input(i-3,j-1) > cb)
                  if( input(i-2,j-2) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             if( input(i-2,j+2) > cb)
              if( input(i-3,j+1) > cb)
               if( input(i-3,j) > cb)
                if( input(i-3,j-1) > cb)
                 if( input(i-2,j-2) > cb)
                  if( input(i-1,j-3) > cb)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
         else if( input(i+1,j+3) < c_b)
          if( input(i,j+3) < c_b)
           if( input(i-1,j+3) < c_b)
            if( input(i+2,j+2) < c_b)
             if( input(i+3,j+1) < c_b)
              if( input(i+3,j) < c_b)
               if( input(i+3,j-1) < c_b)
                if( input(i+2,j-2) < c_b)
                 if( input(i+1,j-3) < c_b)
                  goto is_a_corner;
                 else
                  if( input(i-2,j+2) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                else
                 if( input(i-2,j+2) < c_b)
                  if( input(i-3,j+1) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
               else
                if( input(i-2,j+2) < c_b)
                 if( input(i-3,j+1) < c_b)
                  if( input(i-3,j) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
              else
               if( input(i-2,j+2) < c_b)
                if( input(i-3,j+1) < c_b)
                 if( input(i-3,j) < c_b)
                  if( input(i-3,j-1) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
             else
              if( input(i-2,j+2) < c_b)
               if( input(i-3,j+1) < c_b)
                if( input(i-3,j) < c_b)
                 if( input(i-3,j-1) < c_b)
                  if( input(i-2,j-2) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
            else
             if( input(i-2,j+2) < c_b)
              if( input(i-3,j+1) < c_b)
               if( input(i-3,j) < c_b)
                if( input(i-3,j-1) < c_b)
                 if( input(i-2,j-2) < c_b)
                  if( input(i-1,j-3) < c_b)
                   goto is_a_corner;
                  else
                   goto is_not_a_corner;
                 else
                  goto is_not_a_corner;
                else
                 goto is_not_a_corner;
               else
                goto is_not_a_corner;
              else
               goto is_not_a_corner;
             else
              goto is_not_a_corner;
           else
            goto is_not_a_corner;
          else
           goto is_not_a_corner;
         else
          goto is_not_a_corner;

		is_a_corner:
			output(i,j) = 300;
			goto end_if;

		is_not_a_corner:
            		output(i,j) = input(i,j);
			goto end_if;

		end_if:
			return;
    }
}
