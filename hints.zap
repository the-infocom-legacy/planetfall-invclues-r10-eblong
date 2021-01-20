

	.FUNCT	V-HINTS-NO
	EQUAL?	PRSO,ROOMS /?CCL3
	PRINTI	"I don't understand what you mean."
	CRLF	
	RETURN	2
?CCL3:	SET	'HINTS-OFF,TRUE-VALUE
	PRINTI	"[Hints have been disallowed for this session.]"
	CRLF	
	RETURN	2


	.FUNCT	V-HINT,CHR,MAXC,C,Q,WHO
?FCN:	EQUAL?	HINTS-OFF,-1 \?CCL3
	SET	'HINTS-OFF,0
	PRINTI	"[Warning: It is recognized that the temptation for help may at times be so exceedingly strong that you might fetch hints prematurely. Therefore, you may at any time during the story type HINTS OFF, and this will disallow the seeking out of help for the present session of the story. If you still want a hint now, indicate HINT.]"
	CRLF	
	RETURN	2
?CCL3:	ZERO?	HINTS-OFF /?CND1
	ICALL	PERFORM,V?HINTS-NO,ROOMS
	RETURN	2
?CND1:	GET	HINTS,0 >MAXC
	ICALL1	INIT-HINT-SCREEN
	CURSET	5,1
	ICALL1	PUT-UP-CHAPTERS
	SUB	CHAPT-NUM,1 >CUR-POS
	ICALL1	NEW-CURSOR
?PRG9:	INPUT	1 >CHR
	EQUAL?	CHR,81,113 \?CCL13
	SET	'Q,TRUE-VALUE
	JUMP	?REP10
?CCL13:	EQUAL?	CHR,78,110 \?CCL15
	ICALL1	ERASE-CURSOR
	EQUAL?	CHAPT-NUM,MAXC \?CCL18
	SET	'CUR-POS,0
	SET	'CHAPT-NUM,1
	SET	'QUEST-NUM,1
	JUMP	?CND16
?CCL18:	INC	'CUR-POS
	INC	'CHAPT-NUM
	SET	'QUEST-NUM,1
?CND16:	ICALL1	NEW-CURSOR
	JUMP	?PRG9
?CCL15:	EQUAL?	CHR,80,112 \?CCL20
	ICALL1	ERASE-CURSOR
	EQUAL?	CHAPT-NUM,1 \?CCL23
	SET	'CHAPT-NUM,MAXC
	SUB	MAXC,1 >CUR-POS
	JUMP	?CND21
?CCL23:	DEC	'CUR-POS
	DEC	'CHAPT-NUM
?CND21:	SET	'QUEST-NUM,1
	ICALL1	NEW-CURSOR
	JUMP	?PRG9
?CCL20:	EQUAL?	CHR,13,10 \?PRG9
	ICALL1	PICK-QUESTION
?REP10:	ZERO?	Q /?FCN
	CLEAR	-1
	ICALL1	INIT-STATUS-LINE
	PRINTI	"Back to the story ..."
	CRLF	
	RETURN	2


	.FUNCT	PICK-QUESTION,CHR,MAXQ,Q
?FCN:	ICALL2	INIT-HINT-SCREEN,FALSE-VALUE
	ICALL	LEFT-LINE,3,RETURN-SEE-HINT,RETURN-SEE-HINT-LEN
	ICALL	RIGHT-LINE,3,Q-MAIN-MENU,Q-MAIN-MENU-LEN
	GET	HINTS,CHAPT-NUM
	GET	STACK,0
	SUB	STACK,1 >MAXQ
	CURSET	5,1
	ICALL1	PUT-UP-QUESTIONS
	SUB	QUEST-NUM,1 >CUR-POS
	ICALL1	NEW-CURSOR
?PRG1:	INPUT	1 >CHR
	EQUAL?	CHR,81,113 \?CCL5
	SET	'Q,TRUE-VALUE
	JUMP	?REP2
?CCL5:	EQUAL?	CHR,78,110 \?CCL7
	ICALL1	ERASE-CURSOR
	EQUAL?	QUEST-NUM,MAXQ \?CCL10
	SET	'CUR-POS,0
	SET	'QUEST-NUM,1
	JUMP	?CND8
?CCL10:	INC	'CUR-POS
	INC	'QUEST-NUM
?CND8:	ICALL1	NEW-CURSOR
	JUMP	?PRG1
?CCL7:	EQUAL?	CHR,80,112 \?CCL12
	ICALL1	ERASE-CURSOR
	EQUAL?	QUEST-NUM,1 \?CCL15
	SET	'QUEST-NUM,MAXQ
	SUB	MAXQ,1 >CUR-POS
	JUMP	?CND13
?CCL15:	DEC	'CUR-POS
	DEC	'QUEST-NUM
?CND13:	ICALL1	NEW-CURSOR
	JUMP	?PRG1
?CCL12:	EQUAL?	CHR,13,10 \?PRG1
	ICALL1	DISPLAY-HINT
?REP2:	ZERO?	Q /?FCN
	RFALSE	


	.FUNCT	ERASE-CURSOR,?TMP1
	GET	LINE-TABLE,CUR-POS >?TMP1
	GET	COLUMN-TABLE,CUR-POS
	SUB	STACK,2
	CURSET	?TMP1,STACK
	PRINTC	32
	RTRUE	


	.FUNCT	NEW-CURSOR,?TMP1
	GET	LINE-TABLE,CUR-POS >?TMP1
	GET	COLUMN-TABLE,CUR-POS
	SUB	STACK,2
	CURSET	?TMP1,STACK
	PRINTC	62
	RTRUE	


	.FUNCT	INVERSE-LINE,CENTER-HALF
	HLIGHT	H-INVERSE
	GETB	0,33
	ICALL2	PRINT-SPACES,STACK
	HLIGHT	H-NORMAL
	RTRUE	


	.FUNCT	DISPLAY-HINT,H,MX,CNT,CHR,FLG,N,CV,SHIFT?,COUNT-OFFS,CURCX,CURC,?TMP1
	SET	'CNT,2
	SET	'FLG,TRUE-VALUE
	CLEAR	-1
	SPLIT	3
	SCREEN	S-WINDOW
	CURSET	1,1
	ICALL1	INVERSE-LINE
	ICALL	CENTER-LINE,1,INVISICLUES,INVISICLUES-LEN
	CURSET	3,1
	ICALL1	INVERSE-LINE
	ICALL	LEFT-LINE,3,STR?824
	ICALL	RIGHT-LINE,3,Q-SEE-HINT-MENU,Q-SEE-HINT-MENU-LEN
	CURSET	2,1
	ICALL1	INVERSE-LINE
	HLIGHT	H-BOLD
	GET	HINTS,CHAPT-NUM >?TMP1
	ADD	QUEST-NUM,1
	GET	?TMP1,STACK >H
	SUB	CHAPT-NUM,1
	GET	HINT-COUNTS,STACK >CV
	GET	H,1
	ICALL	CENTER-LINE,2,STACK
	HLIGHT	H-NORMAL
	GET	H,0 >MX
	SCREEN	S-TEXT
	CRLF	
	MOD	QUEST-NUM,2 >SHIFT?
	SUB	QUEST-NUM,1
	DIV	STACK,2 >COUNT-OFFS
	GETB	CV,COUNT-OFFS >CURCX
	ZERO?	SHIFT? /?CCL3
	SHIFT	CURCX,-4
	JUMP	?CND1
?CCL3:	PUSH	CURCX
?CND1:	BAND	STACK,15
	ADD	2,STACK >CURC
?PRG4:	EQUAL?	CNT,CURC /?PRG9
	GET	H,CNT
	PRINT	STACK
	CRLF	
	INC	'CNT
	JUMP	?PRG4
?PRG9:	ZERO?	FLG /?CCL13
	GRTR?	CNT,MX \?CCL13
	SET	'FLG,FALSE-VALUE
	PRINTI	"[That's all.]"
	CRLF	
	JUMP	?CND11
?CCL13:	ZERO?	FLG /?CND11
	SUB	MX,CNT
	ADD	STACK,1 >N
	PRINTC	91
	PRINTN	N
	PRINTI	" hint"
	EQUAL?	N,1 /?CND17
	PRINTC	115
?CND17:	PRINTI	" left.] -> "
	SET	'FLG,FALSE-VALUE
?CND11:	INPUT	1 >CHR
	EQUAL?	CHR,81,113 \?CCL21
	ZERO?	SHIFT? /?CCL24
	GETB	CV,COUNT-OFFS
	BAND	STACK,15 >?TMP1
	SUB	CNT,2
	SHIFT	STACK,4
	BOR	?TMP1,STACK
	PUTB	CV,COUNT-OFFS,STACK
	RTRUE	
?CCL24:	GETB	CV,COUNT-OFFS
	BAND	STACK,240 >?TMP1
	SUB	CNT,2
	BOR	?TMP1,STACK
	PUTB	CV,COUNT-OFFS,STACK
	RTRUE	
?CCL21:	EQUAL?	CHR,13,10 \?PRG9
	GRTR?	CNT,MX /?PRG9
	SET	'FLG,TRUE-VALUE
	GET	H,CNT
	PRINT	STACK
	CRLF	
	IGRTR?	'CNT,MX \?PRG9
	SET	'FLG,FALSE-VALUE
	PRINTI	"[Final hint]"
	CRLF	
	JUMP	?PRG9


	.FUNCT	PUT-UP-QUESTIONS,ST,MXQ,MXL,?TMP1
	SET	'ST,1
	GET	HINTS,CHAPT-NUM
	GET	STACK,0
	SUB	STACK,1 >MXQ
	GETB	0,32
	SUB	STACK,1 >MXL
?PRG1:	GRTR?	ST,MXQ /TRUE
	SUB	ST,1
	GET	LINE-TABLE,STACK >?TMP1
	SUB	ST,1
	GET	COLUMN-TABLE,STACK
	SUB	STACK,1
	CURSET	?TMP1,STACK
	PRINTC	32
	GET	HINTS,CHAPT-NUM >?TMP1
	ADD	ST,1
	GET	?TMP1,STACK
	GET	STACK,1
	PRINT	STACK
	INC	'ST
	JUMP	?PRG1


	.FUNCT	PUT-UP-CHAPTERS,ST,MXC,MXL,?TMP1
	SET	'ST,1
	GET	HINTS,0 >MXC
	GETB	0,32
	SUB	STACK,1 >MXL
?PRG1:	GRTR?	ST,MXC /TRUE
	SUB	ST,1
	GET	LINE-TABLE,STACK >?TMP1
	SUB	ST,1
	GET	COLUMN-TABLE,STACK
	SUB	STACK,1
	CURSET	?TMP1,STACK
	PRINTC	32
	GET	HINTS,ST
	GET	STACK,1
	PRINT	STACK
	INC	'ST
	JUMP	?PRG1


	.FUNCT	INIT-HINT-SCREEN,THIRD
	ASSIGNED?	'THIRD /?CND1
	SET	'THIRD,TRUE-VALUE
?CND1:	CLEAR	-1
	GETB	0,32
	SUB	STACK,1
	SPLIT	STACK
	SCREEN	S-WINDOW
	CURSET	1,1
	ICALL1	INVERSE-LINE
	CURSET	2,1
	ICALL1	INVERSE-LINE
	CURSET	3,1
	ICALL1	INVERSE-LINE
	ICALL	CENTER-LINE,1,INVISICLUES,INVISICLUES-LEN
	ICALL	LEFT-LINE,2,STR?825
	ICALL	RIGHT-LINE,2,PREVIOUS,PREVIOUS-LEN
	ZERO?	THIRD /FALSE
	ICALL	LEFT-LINE,3,STR?826
	CALL	RIGHT-LINE,3,Q-RESUME-STORY,Q-RESUME-STORY-LEN
	RSTACK	


	.FUNCT	CENTER-LINE,LN,STR,LEN,INV
	ASSIGNED?	'INV /?CND1
	SET	'INV,TRUE-VALUE
?CND1:	ZERO?	LEN \?CND3
	DIROUT	D-TABLE-ON,DIROUT-TBL
	PRINT	STR
	DIROUT	D-TABLE-OFF
	GET	DIROUT-TBL,0 >LEN
?CND3:	GETB	0,33
	SUB	STACK,LEN
	DIV	STACK,2
	CURSET	LN,STACK
	ZERO?	INV /?CND5
	HLIGHT	H-INVERSE
?CND5:	PRINT	STR
	ZERO?	INV /FALSE
	HLIGHT	H-NORMAL
	RTRUE	


	.FUNCT	LEFT-LINE,LN,STR,INV
	ASSIGNED?	'INV /?CND1
	SET	'INV,TRUE-VALUE
?CND1:	CURSET	LN,1
	ZERO?	INV /?CND3
	HLIGHT	H-INVERSE
?CND3:	PRINT	STR
	ZERO?	INV /FALSE
	HLIGHT	H-NORMAL
	RTRUE	


	.FUNCT	RIGHT-LINE,LN,STR,LEN,INV
	ASSIGNED?	'INV /?CND1
	SET	'INV,TRUE-VALUE
?CND1:	ZERO?	LEN \?CND3
	DIROUT	3,DIROUT-TBL
	PRINT	STR
	DIROUT	-3
	GET	DIROUT-TBL,0 >LEN
?CND3:	GETB	0,33
	SUB	STACK,LEN
	CURSET	LN,STACK
	ZERO?	INV /?CND5
	HLIGHT	H-INVERSE
?CND5:	PRINT	STR
	ZERO?	INV /FALSE
	HLIGHT	H-NORMAL
	RTRUE	

	.ENDI
