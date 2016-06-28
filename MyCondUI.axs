MODULE_NAME='MyCondUI'(DEV vdvMyCondUI, DEV vdvModbusPort, char PanId, char OldPanStates[], char NewPanStates[], char IgnoreNewVal)
(***********************************************************)
(***********************************************************)
(*  FILE_LAST_MODIFIED_ON: 04/04/2006  AT: 11:33:16        *)
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(* REV HISTORY:                                            *)
(***********************************************************)
(*
    $History: $
*)    
(***********************************************************)
(*          DEVICE NUMBER DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*               CONSTANT DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_CONSTANT

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*               VARIABLE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_VARIABLE


(***********************************************************)
(*               LATCHING DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_LATCHING

(***********************************************************)
(*       MUTUALLY EXCLUSIVE DEFINITIONS GO BELOW           *)
(***********************************************************)
DEFINE_MUTUALLY_EXCLUSIVE

(***********************************************************)
(*        SUBROUTINE/FUNCTION DEFINITIONS GO BELOW         *)
(***********************************************************)
(* EXAMPLE: DEFINE_FUNCTION <RETURN_TYPE> <NAME> (<PARAMETERS>) *)
(* EXAMPLE: DEFINE_CALL '<NAME>' (<PARAMETERS>) *)
DEFINE_CALL 'IgnoreIncommingData'
{
    IgnoreNewVal = 1;
    wait 10 'IgnoreNewValues'
    {
	IgnoreNewVal = 0;
    }
}
(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT
BUTTON_EVENT[vdvMyCondUI,1]
{
    PUSH:
    {
	if([vdvMyCondUI,1])
	{
	    SEND_COMMAND vdvModbusPort, "'PANNEL_OFF_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,1];
	}
	else
	{
	    SEND_COMMAND vdvModbusPort, "'PANNEL_ON_PAN_ID_',itoa(PanId)";
	    on[vdvMyCondUI,1];
	}
	CALL 'IgnoreIncommingData';
    }
}
BUTTON_EVENT[vdvMyCondUI,2]
{
    PUSH:
    {
	if([vdvMyCondUI,2])
	{
	    SEND_COMMAND vdvModbusPort, "'PANNEL_UNLOCK_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,2];
	}
	else
	{
	    SEND_COMMAND vdvModbusPort, "'PANNEL_LOCK_PAN_ID_',itoa(PanId)";
	    on[vdvMyCondUI,2];
	}
	CALL 'IgnoreIncommingData';
    }
}


BUTTON_EVENT[vdvMyCondUI,11]
{
    PUSH:
    {
	if([vdvMyCondUI,3])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_MODE_1_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,3];
	    on[vdvMyCondUI,4];
	}
	else if([vdvMyCondUI,4])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_MODE_2_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,4];
	    on[vdvMyCondUI,3];
	}
	CALL 'IgnoreIncommingData';
    }
}
BUTTON_EVENT[vdvMyCondUI,12]
{
    PUSH:
    {
	if([vdvMyCondUI,6])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_FAN_SPEED_2_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,6];
	    off[vdvMyCondUI,8];
	    off[vdvMyCondUI,9];
	    on[vdvMyCondUI,7];
	}
	else if([vdvMyCondUI,7])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_FAN_SPEED_3_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,6];
	    off[vdvMyCondUI,7];
	    off[vdvMyCondUI,9];
	    on[vdvMyCondUI,8];
	}
	else if([vdvMyCondUI,8])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_FAN_SPEED_4_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,6];
	    off[vdvMyCondUI,8];
	    off[vdvMyCondUI,7];
	    on[vdvMyCondUI,9];
	}
	else if([vdvMyCondUI,9])
	{
	    SEND_COMMAND vdvModbusPort, "'SET_FAN_SPEED_1_PAN_ID_',itoa(PanId)";
	    off[vdvMyCondUI,7];
	    off[vdvMyCondUI,8];
	    off[vdvMyCondUI,9];
	    on[vdvMyCondUI,6];
	}
	CALL 'IgnoreIncommingData';
    }
}

BUTTON_EVENT[vdvMyCondUI,13]
{
    PUSH:
    {
	if((OldPanStates[5]+1)<31)
	{
	    OldPanStates[5] = (OldPanStates[5]+1);
	    send_level vdvMyCondUI, 3, OldPanStates[5];
	    send_level vdvMyCondUI, 1, OldPanStates[5];
	}
	CALL 'IgnoreIncommingData';
    }
    HOLD [10, REPEAT]:
    {
	if((OldPanStates[5]+5)<31)
	{
	    OldPanStates[5] = (OldPanStates[5]+5);
	    send_level vdvMyCondUI, 3, OldPanStates[5] ;
	    send_level vdvMyCondUI, 1, OldPanStates[5] ;
	}
	else
	{
	    send_level vdvMyCondUI, 3, 30;
	    send_level vdvMyCondUI, 1, 10;
	}
	CALL 'IgnoreIncommingData';
    }
    
}
BUTTON_EVENT[vdvMyCondUI,14]
{
    PUSH:
    {
	
	if((OldPanStates[5]-1)>9)
	{
	    OldPanStates[5] = (OldPanStates[5]-1);
	    send_level vdvMyCondUI, 3, OldPanStates[5];
	    send_level vdvMyCondUI, 1, OldPanStates[5];
	}
	CALL 'IgnoreIncommingData';
    }
    HOLD [10, REPEAT]:
    {
	if((OldPanStates[5]-5)>9)
	{
	    OldPanStates[5] = (OldPanStates[5]-5);
	    send_level vdvMyCondUI, 3, OldPanStates[5];
	    send_level vdvMyCondUI, 1, OldPanStates[5];
	}
	else
	{
	    send_level vdvMyCondUI, 3, 10;
	    send_level vdvMyCondUI, 1, 10;
	}
	CALL 'IgnoreIncommingData';
    }
}

LEVEL_EVENT[vdvMyCondUI,3]
{
    SEND_COMMAND vdvModbusPort, "'SET_PAN_TEMP_',itoa(LEVEL.VALUE),'_PAN_ID_',itoa(PanId)";
}


DATA_EVENT[vdvMyCondUI]
{ 
    COMMAND:
    {
	char CMD[20];
	SELECT
	{
	    ACTIVE(FIND_STRING(data.text,'NEW_DATA:',1)):
	    {
		if(IgnoreNewVal = 0)
		{
		    CMD = data.text;
		    ON [vdvMyCondUI,10];
		    REMOVE_STRING (CMD,'NEW_DATA:',1);
		    NewPanStates[1] = CMD[1];
		    //Проверка изменилось ли состояние панели (ВКЛ/ВЫКЛ)
		    if(NewPanStates[1] != OldPanStates [1])
		    {
			OldPanStates [1] = NewPanStates[1];
			if (NewPanStates[1] == 1){ON [vdvMyCondUI,1];}
			else if (NewPanStates[1] == 0) {OFF [vdvMyCondUI,1];}
			else if (NewPanStates[1] == 2) {OFF [vdvMyCondUI,1];}
		    }
		    
		    NewPanStates[2] = CMD[2];
		    //Проверка изменился ли режим работы панели (Снежинка/Солнышко)
		    if(NewPanStates[2] != OldPanStates [2])
		    {
			OldPanStates [2] = NewPanStates[2];
			switch(NewPanStates[2])
			{
			    case 1:  //Режим "Снежинка"
			    {
				ON [vdvMyCondUI,4]; 
				OFF [vdvMyCondUI,3];
			    }
			    case 2:  //Режим "Солнышко"
			    {
				ON [vdvMyCondUI,3]; 
				OFF [vdvMyCondUI,4];
			    }
			    DEFAULT:
			    {
				//ERROR!
			    }
			}
		    }
		    //Проверка изменилась ли cкорость вентилятора 
		    //(1 - первая, 2 - вторая, 3 - третья, 4..6 - авто)
		    NewPanStates[3] = CMD[3];
		    if(NewPanStates[3] != OldPanStates [3])
		    {
			OldPanStates [3] = NewPanStates[3];
			if(NewPanStates[3]>3)
			{
			    ON [vdvMyCondUI,9]; 
			    OFF [vdvMyCondUI,6];
			    OFF [vdvMyCondUI,7];
			    OFF [vdvMyCondUI,8];
			}
			else
			{
			    switch(NewPanStates[3])
			    {
				case 1:  //СКОРОСТЬ 1
				{
				    ON [vdvMyCondUI,6]; 
				    OFF [vdvMyCondUI,7];
				    OFF [vdvMyCondUI,8];
				    OFF [vdvMyCondUI,9];
				}
				case 2:  //СКОРОСТЬ 2
				{
				    ON [vdvMyCondUI,7]; 
				    OFF [vdvMyCondUI,6];
				    OFF [vdvMyCondUI,8];
				    OFF [vdvMyCondUI,9];
				}
				case 3:  //СКОРОСТЬ 3
				{
				    ON [vdvMyCondUI,8]; 
				    OFF [vdvMyCondUI,7];
				    OFF [vdvMyCondUI,6];
				    OFF [vdvMyCondUI,9];
				}
				case 4:  //AUTO
				case 5:  //AUTO
				case 6:  //AUTO
				case 7:  //AUTO
				{
				    ON [vdvMyCondUI,9]; 
				    OFF [vdvMyCondUI,7];
				    OFF [vdvMyCondUI,6];
				    OFF [vdvMyCondUI,8];
				}
				DEFAULT:
				{
				    //ERROR!
				}
			    }
			}
		    }
		    
		    //Проверка изменилась ли Температура измеренная панелью 
		    NewPanStates[4] = CMD[4];
		    if(NewPanStates[4] != OldPanStates [4])
		    {
			OldPanStates [4] = NewPanStates[4];
			SEND_LEVEL vdvMyCondUI,2, NewPanStates[4];
		    }
		    
		    //Проверка изменилась ли Температура установленная на панели
		    NewPanStates[5] = CMD[5];
		    if(NewPanStates[5] != OldPanStates [5])
		    {
			OldPanStates [5] = NewPanStates[5];
			SEND_LEVEL vdvMyCondUI,1, NewPanStates[5];
			(*if((NewPanStates[5]>9)&&(NewPanStates[5]<31))
			{
			    
			}*)
		    }
		    
		    //Проверка изменилось ли состояние панели (заблокировано /нет)
		    NewPanStates[6] = CMD[6];
		    if(NewPanStates[6] != OldPanStates [6])
		    {
			OldPanStates [6] = NewPanStates[6];
			if (NewPanStates[6]){ON [vdvMyCondUI,2];}
			else {OFF [vdvMyCondUI,2];}
		    }
		}
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_OFFLINE',1)):
	    {
		if(IgnoreNewVal = 0)
		{
		    //OFF [vdvMyCondUI,1];
		    OFF [vdvMyCondUI,10];
		    NewPanStates[1] = 2;
		}
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_ONLINE',1)):
	    {
		if(IgnoreNewVal = 0)
		{
		    //OFF [vdvMyCondUI,1];
		    ON [vdvMyCondUI,10];
		    NewPanStates[1] = 2;
		}
	    }
	}
    }
    
}
(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM



(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
