JUMPS
IDEAL
MODEL small
STACK 100h
DATASEG
filename db 'menu.bmp',0
filehandle dw ?
Header db 54 dup (0)
Palette db 256*4 dup (0)
ScrLine db 320 dup (0)
ErrorMsg db 'Error', 13, 10 ,'$'

game_width dw 140h
game_height dw 0c8h
window_bounds dw 10

time_aux db 0

pacman_x dw 10 ;x staposition
pacman_y dw 20 ;y position
pacman_velocity_x dw 05h
pacman_velocity_y dw 05h

red_ghost_x dw 98h
red_ghost_y dw 64h
blue_ghost_x dw 98h
blue_ghost_y dw 64h
pink_ghost_x dw 98h
pink_ghost_y dw 64h
green_ghost_x dw 98h
green_ghost_y dw 64h
ghosts_velocity_x dw 02h
ghosts_velocity_y dw 02h
ghosts_size dw 8

point_x dw 0
point_y dw 0
max_points_ob dw 1
points_num dw 0
points_xy dw 103,81,98,74,113,170,67,20,86,40,19,50,130,165,58,51,195,166,78,29,25,141,120,34,80,149,88,191,54,38,102,94,133,52,90,190,69,189,160,117,85,151,111,61,182,138,30,147,100,96
score db 0

game_over_txt db  10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, "             ", "*" ," GAME OVER " ,"*", 10, 13,10, 13, "$"
win_txt db  10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, 10, 13, "          ", "*" ," VICTORY ROYALE " ,"*", 10, 13,10, 13, "$"
msg db  10, 13, 10, 13, "          ", " Press ESC to exit " , 10, 13,10, 13, "$"
score_txt db 10, 13, " Score: ", '0', '0', "$"
best_score db 10,13,"               ", "Score: 50", "$"

CODESEG

proc main

	call clear_screen
	
	check_time:
		mov ah,2ch
		int 21h
	
		cmp dl,[time_aux]
		je check_time
		mov [time_aux],dl
		
		call clear_screen
		
		call scoring
		
		call pacman_movement
		call draw_pacman
		
		;red ghost
		call red_ghost_movement
		call draw_red_ghost
		;blue ghost
		call blue_ghost_movement
		call draw_blue_ghost
		;pink ghost
		call pink_ghost_movement
		call draw_pink_ghost
		;green ghost
		call green_ghost_movement
		call draw_green_ghost
		
		call ghosts_collision
		
		call draw_points
		push ax
		push bx
		call points_collision
		pop bx
		pop ax
		
		jmp check_time
	
	jmp main
	
	ret
	
endp main


proc clear_screen

	mov ah,0
	mov al,13h
	int 10h

	mov ah,0Bh
	mov bh,00h
	mov bl,00h
	int 10h
	
	ret
	
endp clear_screen


proc draw_pacman

	mov cx, [pacman_x]
    mov dx, [pacman_y]
	mov ax, cx
	add ax,6

    line1:
		push ax
        mov al, 0Eh
        mov ah, 0Ch
        int 10h

        inc cx

        pop ax
        cmp cx, ax
        jbe line1

	add dx, 1
    sub cx, 8
    add ax, 1

    line2:
	    push ax
        mov al, 0Eh
        mov ah, 0Ch
        int 10h

        inc cx
		
        pop ax
        cmp cx, ax
        jbe line2
				
    add dx, 1
    sub cx, 10
    add ax, 1
	
    line3:
	    push ax
        mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line3
		
	add dx, 1
    sub cx, 11
    add ax, 1
	
	line4:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line4
		
	add dx, 1
    sub cx, 12
    ;pop ax
    ;add ax, 1
    ;push ax
	
	line5:
		push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line5
		
	add dx, 1
    sub cx, 13
    sub ax, 2
	
	line6:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line6
		
	add dx, 1
    sub cx, 11
    sub ax, 3
	
	line7:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line7
		
	add dx, 1
    sub cx, 8
    sub ax, 2
	
	line8:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line8
		
	add dx, 1
    sub cx, 6
    add ax, 2
	
	line9:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line9
		
	add dx, 1
    sub cx, 8
    add ax, 3
	
	line10:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line10
		
	add dx, 1
    sub cx, 11
    add ax, 2
	
	line11:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line11
		
	add dx, 1
    sub cx, 12
    ;pop ax
    ;add ax, 02h
    ;push ax
	
	line12:
		push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line12
		
	add dx, 1
    sub cx, 12
    ;pop ax
    sub ax, 1
	
	line13:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line13
		
	add dx, 1
    sub cx, 10
    sub ax, 1
	
	line14:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line14
		
	add dx, 1
    sub cx, 8
    sub ax, 1
	
	line15:
	    push ax
		mov al, 0Eh
        mov ah, 0Ch
        int 10h
		
		inc cx
		
		pop ax
		cmp cx, ax
		jbe line15
	
	ret

endp draw_pacman


proc pacman_movement
	
	;check if any key is being pressed
	mov ah,01h
	int 16h
	jz check_pacman_movement
	
	;check which key is being pressed
	mov ah,00h
	int 16h
	
	;if it is 'd' or 'D' move right
	cmp al,64h ;'d'
	je move_right
	cmp al,44h ;'D'
	je move_right
	
	;if it is 'a' or 'A' move left
	cmp al,61h ;'a'
	je move_left
	cmp al,41h ;'A'
	je move_left

	;if it is 'w' or 'W' move up
	cmp al,77h ;'w'
	je move_down
	cmp al,57h ;'W'
	je move_down

	;if it is 's' or 'S' move down
	cmp al,73h ;'s'
	je move_up
	cmp al,53h ;'S'
	je move_up
	
	move_right:
		mov ax, [pacman_velocity_x]
		add [pacman_x], ax
		jmp check_pacman_movement
		
	move_left:
		cmp [pacman_x], 5
		je no
		mov ax, [pacman_velocity_x]
		sub [pacman_x], ax
		jmp check_pacman_movement
	
	move_up:
		mov ax, [pacman_velocity_y]
		add [pacman_y], ax
		jmp check_pacman_movement
		
	move_down:
		mov ax, [pacman_velocity_y]
		sub [pacman_y], ax
		jmp check_pacman_movement
		
	no:
		ret
		
	check_pacman_movement:
	
	ret

endp pacman_movement


proc ghosts_collision

	;red ghost collision
	mov bx, 7
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	gtop_line:
		mov ah, 0dh
		int 10h
	
		cmp al, 04h
		je lose
		cmp al, 0bh
		je lose
		cmp al, 0dh
		je lose
		cmp al, 0ah
		je lose
		inc cx
		dec bx
		cmp bx, 0
		ja gtop_line
	
	mov bx, 7
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	add dx, 14
	gbot_line:
		mov ah, 0dh
		int 10h
	
		cmp al, 04h
		je lose
		cmp al, 0bh
		je lose
		cmp al, 0dh
		je lose
		cmp al, 0ah
		je lose
		inc cx
		dec bx
		cmp bx, 0
		ja gbot_line
		
	mov bx, 7
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 4
	gleft_line:
		mov ah, 0dh
		int 10h
	
		cmp al, 04h
		je lose
		cmp al, 0bh
		je lose
		cmp al, 0dh
		je lose
		cmp al, 0ah
		je lose
		inc dx
		dec bx
		cmp bx, 0
		ja gleft_line
		
	mov bx, 9
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	add cx, 9
	add dx, 3
	gright_line:
		mov ah, 0dh
		int 10h
	
		cmp al, 04h
		je lose
		cmp al, 0bh
		je lose
		cmp al, 0dh
		je lose
		cmp al, 0ah
		je lose
		inc dx
		dec bx
		cmp bx, 0
		ja gright_line
	
	ret
	
	lose:
		call game_over
		
		ret

endp ghosts_collision


proc draw_red_ghost

	mov cx, [red_ghost_x]
    mov dx, [red_ghost_y]
	mov ax, dx
	add ax, 9
	
    rline1:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline1
		
	add cx, 1
    sub dx, 14
    sub ax, 1
	
	rline2:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline2
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	rline3:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline3
		
	add cx, 1
    sub dx, 13
    add ax, 2
	
	rline4:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline4
		
	add cx, 1
    sub dx, 15
    add ax, 1
	
	rline5:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline5
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	rline6:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline6
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	rline7:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline7
		
	add cx, 1
    sub dx, 17
    sub ax, 3
	
	rline8:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline8
		
	add cx, 1
    sub dx, 14
    ;sub ax, 0
	
	rline9:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline9
		
	add cx, 1
    sub dx, 14
    add ax, 3
	
	rline10:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline10
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	rline11:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline11
		
	add cx, 1
    sub dx, 16
    ;add ax, 0
	
	rline12:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline12
		
	add cx, 1
    sub dx, 16
    sub ax, 1
	
	rline13:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline13
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	rline14:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline14
		
	add cx, 1
    sub dx, 11
    add ax, 2
	
	rline15:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline15
		
	add cx, 1
    sub dx, 9
    add ax, 1
	
	rline16:
		push ax
        mov al, 04h ;red color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe rline16

	ret
	
endp draw_red_ghost

proc red_ghost_movement
	
	;right-up movement
	mov ax,[ghosts_velocity_x]
	add [red_ghost_x],ax
	mov ax,[ghosts_velocity_y]
	add [red_ghost_y],ax

	;left wall
	cmp [red_ghost_x],00h
	jl red_neg_movement_x

	;right wall
	mov ax,[game_width]
	sub ax,[ghosts_size]
	cmp [red_ghost_x],ax
	jg red_neg_movement_x

	;top wall
	cmp [red_ghost_y],00h
	jl red_neg_movement_y

	;bottom wall
	mov ax,[game_height]
	sub ax,[ghosts_size]
	cmp [red_ghost_y],ax
	jg red_neg_movement_y

	ret

	red_neg_movement_x:
		neg [ghosts_velocity_x]
		ret
	red_neg_movement_y:
		neg [ghosts_velocity_y]
		ret
	
endp red_ghost_movement

proc draw_blue_ghost

	mov cx, [blue_ghost_x]
    mov dx, [blue_ghost_y]
	mov ax, dx
	add ax, 9
	
    bline1:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline1
		
	add cx, 1
    sub dx, 14
    sub ax, 1
	
	bline2:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline2
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	bline3:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline3
		
	add cx, 1
    sub dx, 13
    add ax, 2
	
	bline4:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline4
		
	add cx, 1
    sub dx, 15
    add ax, 1
	
	bline5:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline5
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	bline6:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline6
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	bline7:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline7
		
	add cx, 1
    sub dx, 17
    sub ax, 3
	
	bline8:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline8
		
	add cx, 1
    sub dx, 14
    ;sub ax, 0
	
	bline9:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline9
		
	add cx, 1
    sub dx, 14
    add ax, 3
	
	bline10:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline10
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	bline11:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline11
		
	add cx, 1
    sub dx, 16
    ;add ax, 0
	
	bline12:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline12
		
	add cx, 1
    sub dx, 16
    sub ax, 1
	
	bline13:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline13
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	bline14:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline14
		
	add cx, 1
    sub dx, 11
    add ax, 2
	
	bline15:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline15
		
	add cx, 1
    sub dx, 9
    add ax, 1
	
	bline16:
		push ax
        mov al, 0bh ;blue color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe bline16

	ret
	
endp draw_blue_ghost

proc blue_ghost_movement
	
	;right-down movement
	mov ax,[ghosts_velocity_x]
	add [blue_ghost_x],ax
	mov ax,[ghosts_velocity_y]
	sub [blue_ghost_y],ax

	;left wall
	cmp [blue_ghost_x],02h
	jl blue_neg_movement_x

	;right wall
	mov ax,[game_width]
	sub ax,[ghosts_size]
	cmp [blue_ghost_x],ax
	jg blue_neg_movement_x

	;top wall
	cmp [blue_ghost_y],00h
	jl blue_neg_movement_y

	;bottom wall
	mov ax,[game_height]
	sub ax,[ghosts_size]
	cmp [blue_ghost_y],ax
	jg blue_neg_movement_y

	ret

	blue_neg_movement_x:
		neg [ghosts_velocity_x]
		ret
	blue_neg_movement_y:
		neg [ghosts_velocity_y]
		ret
	
endp blue_ghost_movement

proc draw_pink_ghost

	mov cx, [pink_ghost_x]
    mov dx, [pink_ghost_y]
	mov ax, dx
	add ax, 9
	
    pline1:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline1
		
	add cx, 1
    sub dx, 14
    sub ax, 1
	
	pline2:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline2
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	pline3:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline3
		
	add cx, 1
    sub dx, 13
    add ax, 2
	
	pline4:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline4
		
	add cx, 1
    sub dx, 15
    add ax, 1
	
	pline5:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline5
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	pline6:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline6
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	pline7:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline7
		
	add cx, 1
    sub dx, 17
    sub ax, 3
	
	pline8:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline8
		
	add cx, 1
    sub dx, 14
    ;sub ax, 0
	
	pline9:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline9
		
	add cx, 1
    sub dx, 14
    add ax, 3
	
	pline10:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline10
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	pline11:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline11
		
	add cx, 1
    sub dx, 16
    ;add ax, 0
	
	pline12:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline12
		
	add cx, 1
    sub dx, 16
    sub ax, 1
	
	pline13:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline13
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	pline14:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline14
		
	add cx, 1
    sub dx, 11
    add ax, 2
	
	pline15:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline15
		
	add cx, 1
    sub dx, 9
    add ax, 1
	
	pline16:
		push ax
        mov al, 0dh ;pink color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe pline16

	ret
	
endp draw_pink_ghost

proc pink_ghost_movement
	
	;left-up movement
	mov ax,[ghosts_velocity_x]
	sub [pink_ghost_x],ax
	mov ax,[ghosts_velocity_y]
	add [pink_ghost_y],ax

	;left wall
	cmp [pink_ghost_x],02h
	jl pink_neg_movement_x

	;right wall
	mov ax,[game_width]
	sub ax,[ghosts_size]
	cmp [pink_ghost_x],ax
	jg pink_neg_movement_x

	;top wall
	cmp [pink_ghost_y],00h
	jl pink_neg_movement_y

	;bottom wall
	mov ax,[game_height]
	sub ax,[ghosts_size]
	cmp [pink_ghost_y],ax
	jg pink_neg_movement_y

	ret

	pink_neg_movement_x:
		neg [ghosts_velocity_x]
		ret
	pink_neg_movement_y:
		neg [ghosts_velocity_y]
		ret
	
endp pink_ghost_movement

proc draw_green_ghost

	mov cx, [green_ghost_x]
    mov dx, [green_ghost_y]
	mov ax, dx
	add ax, 9
	
    gline1:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline1
		
	add cx, 1
    sub dx, 14
    sub ax, 1
	
	gline2:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline2
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	gline3:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline3
		
	add cx, 1
    sub dx, 13
    add ax, 2
	
	gline4:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline4
		
	add cx, 1
    sub dx, 15
    add ax, 1
	
	gline5:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline5
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	gline6:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline6
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	gline7:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline7
		
	add cx, 1
    sub dx, 17
    sub ax, 3
	
	gline8:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline8
		
	add cx, 1
    sub dx, 14
    ;sub ax, 0
	
	gline9:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline9
		
	add cx, 1
    sub dx, 14
    add ax, 3
	
	gline10:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline10
		
	add cx, 1
    sub dx, 17
    ;add ax, 0
	
	gline11:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline11
		
	add cx, 1
    sub dx, 16
    ;add ax, 0
	
	gline12:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline12
		
	add cx, 1
    sub dx, 16
    sub ax, 1
	
	gline13:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline13
		
	add cx, 1
    sub dx, 14
    sub ax, 2
	
	gline14:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline14
		
	add cx, 1
    sub dx, 11
    add ax, 2
	
	gline15:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline15
		
	add cx, 1
    sub dx, 9
    add ax, 1
	
	gline16:
		push ax
        mov al, 0ah ;green color
        mov ah, 0Ch
        int 10h

        inc dx
		
        pop ax
        cmp dx, ax
        jbe gline16

	ret
	
endp draw_green_ghost

proc green_ghost_movement
	
	;left-down movement
	mov ax,[ghosts_velocity_x]
	sub [green_ghost_x],ax
	mov ax,[ghosts_velocity_y]
	sub [green_ghost_y],ax

	;left wall
	cmp [green_ghost_x],02h
	jl green_neg_movement_x

	;right wall
	mov ax,[game_width]
	sub ax,[ghosts_size]
	cmp [green_ghost_x],ax
	jg green_neg_movement_x

	;top wall
	cmp [green_ghost_y],00h
	jl green_neg_movement_y

	;bottom wall
	mov ax,[game_height]
	sub ax,[ghosts_size]
	cmp [green_ghost_y],ax
	jg green_neg_movement_y

	ret

	green_neg_movement_x:
		neg [ghosts_velocity_x]
		ret
	green_neg_movement_y:
		neg [ghosts_velocity_y]
		ret
	
endp green_ghost_movement


proc draw_points

	mov bx, [points_num]
	max_points_st:
		mov ax, [points_xy + bx]
		
		mov [point_x], ax
		mov [point_y], ax

		mov cx, [point_x]
		mov dx, [point_y]
	
		mov al, 1fh ;white color
		mov ah, 0Ch
		int 10h
	
		add bx, 2
		
		cmp bx, [max_points_ob]
		jbe max_points_st
		
		ret

endp draw_points

proc points_collision
	
	mov bx, 7
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	cline1:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline1

	mov bx, 9
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	dec cx
	inc dx
	cline2:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline2
		
	mov bx, 11
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 2
	add dx, 2
	cline3:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline3
		
	mov bx, 12
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	add dx, 3
	cline4:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline4
		
	mov bx, 13
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 4
	cline5:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline5
		
	mov bx, 11
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 5
	cline6:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline6
		
	mov bx, 8
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 6
	cline7:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline7
		
	mov bx, 6
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 7
	cline8:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline8
		
	mov bx, 8
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 8
	cline9:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline9
		
	mov bx, 11
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 9
	cline10:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline10
		
	mov bx, 13
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 3
	add dx, 10
	cline11:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline11
		
	mov bx, 12
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 2
	add dx, 11
	cline12:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline12
		
	mov bx, 11
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	sub cx, 2
	add dx, 12
	cline13:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline13
		
	mov bx, 9
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	dec cx
	add dx, 13
	cline14:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline14
		
	mov bx, 7
	mov cx, [pacman_x]
	mov dx, [pacman_y]
	add dx, 14
	cline15:
		mov ah, 0dh
		int 10h
	
		cmp al, 1fh
		je remove_point
		inc cx
		dec bx
		cmp bx, 0
		ja cline15

	ret
	
	remove_point:
		add [points_num], 2
		inc [score]
		
		ret

endp points_collision


proc scoring

	mov dx, offset score_txt
	mov ah, 9h
	int 21h
	
	mov ah, [score]
	add ah, 30h
	cmp [score_txt + 11], 39h
	je tens
	mov [score_txt + 11], ah
	
	cmp [score_txt + 10], 35h
	je win
	
	ret
	
	tens:
		mov [score_txt + 11], 30h
		inc [score_txt + 10]
		mov [score], 0
		
		ret
		
	win:
		call win_screen

endp scoring


proc game_over
	
	close_game:
		call clear_screen
		
		call draw_red_ghost
		call draw_blue_ghost
		call draw_pink_ghost
		call draw_green_ghost
	
		mov dx, offset score_txt
		mov ah, 9h
		int 21h
		
		mov ah, 09h
		lea dx, [game_over_txt]
		int 21h
		
		mov ah, 09h
		lea dx, [msg]
		int 21h
	
		mov ah,0
		int 16h
		cmp ah, 1
		jne close_game
	
	call exit

	ret

endp game_over

proc win_screen

	close_game2:
		call clear_screen
	
		mov ah, 09h
		lea dx, [win_txt]
		int 21h
		
		mov ah, 09h
		lea dx, [best_score]
		int 21h
		
		mov ah, 09h
		lea dx, [msg]
		int 21h
		
		call draw_pacman
	
		mov ah,0
		int 16h
		cmp ah, 1
		jne close_game2
	
	call exit

	ret

endp win_screen



proc OpenFile
	; Open file
	mov ah, 3Dh
	xor al, al
	mov dx, offset filename
	int 21h
	jc openerror
	mov [filehandle], ax
	ret
openerror :
	mov dx, offset ErrorMsg
	mov ah, 9h
	int 21h
	ret
endp OpenFile
proc ReadHeader
	; Read BMP file header, 54 bytes
	mov ah,3fh
	mov bx, [filehandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	ret
endp ReadHeader 
proc ReadPalette
	; Read BMP file color palette, 256 colors * 4 bytes (400h)
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	ret
endp ReadPalette
proc CopyPal
	; Copy the colors palette to the video memory
	; The number of the first color should be sent to port 3C8h
	; The palette is sent to port 3C9h
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0
	; Copy starting color to port 3C8h
	out dx,al
	; Copy palette itself to port 3C9h
	inc dx
PalLoop:
	; Note: Colors in a BMP file are saved as BGR values rather than RGB .
	mov al,[si+2] ; Get red value .
	shr al,2 ; Max. is 255, but video palette maximal
	; value is 63. Therefore dividing by 4.
	out dx,al ; Send it .
	mov al,[si+1] ; Get green value .
	shr al,2
	out dx,al ; Send it .
	mov al,[si] ; Get blue value .
	shr al,2
	out dx,al ; Send it .
	add si,4 ; Point to next color .
	loop PalLoop
	ret
endp CopyPal
proc CopyBitmap
	mov ax, 0A000h
	mov es, ax
	mov cx,200
	PrintBMPLoop :
	push cx
	mov di,cx
	shl cx,6
	shl di,8
	add di,cx
	mov ah,3fh
	mov cx,320
	mov dx,offset ScrLine
	int 21h
	cld
	mov cx,320
	mov si,offset ScrLine
	rep movsb
	pop cx
	loop PrintBMPLoop
	ret
endp CopyBitmap

start:
	mov ax, @data
	mov ds, ax
	; Graphic mode
	mov ax,13h
	int 10h
	; Process BMP file
	call OpenFile
	call ReadHeader
	call ReadPalette
	call CopyPal
	call CopyBitmap
	; Wait for key press
	mov ah,1
	int 21h
	call main
	
exit:
	call clear_screen
	mov ax, 4c00h
	int 21h
END start
