PROGRAM_NAME='main_test'


INCLUDE 'Devices'
INCLUDE 'MyCondInit'



DEFINE_CONSTANT
devchan b1 = {dv_NI700_IO,1};
devchan b2 = {dv_NI700_IO,2};
devchan b3 = {dv_NI700_IO,3};
devchan b4 = {dv_NI700_IO,4};


DEFINE_VARIABLE


(***********************************************************)
(*                STARTUP CODE GOES BELOW                  *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                THE EVENTS GO BELOW                      *)
(***********************************************************)
DEFINE_EVENT

LEVEL_EVENT[vdvMyCondUI1,1]
{
    if(LEVEL.VALUE > 20)
    {
	on [b1];
    }
    else
    {
	off[b1];
    }
}


(*
2,6,0,2,0,15,104,61


BUTTON_EVENT[b1]
{
       PUSH:
       {
	    
	    
	    (*
	    speed ++;
	    if (speed >4)
	    {
		speed = 1;
	    }
	    CALL 'MyCond_SetFanSpeed'(dv_NI700_COM1, 1,speed);
	    *)
       }
}

BUTTON_EVENT[b2]
{
       PUSH:
       {
	    mode ++;
	    if (mode >2)
	    {
		mode = 1;
	    }
	    CALL 'MyCond_SetMode'(dv_NI700_COM1, 1,mode);
       }
}

BUTTON_EVENT[b3]
{
       PUSH:
       {
	    (*
	    MC_temp++;
	    if(MC_temp<=30)
	    {
		call 'MyCond_SetSetTemperature'(dv_NI700_COM1, 1,MC_temp);
	    }
	    else
	    {
		MC_temp = 30;
	    }
	    *)
	    call 'MyCond_PannelLock'(dv_NI700_COM1, 1);
    }
}
BUTTON_EVENT[b4]
{
       PUSH:
       {
	    (*
	    MC_temp--;
	    if(MC_temp>=10)
	    {
		call 'MyCond_SetSetTemperature'(dv_NI700_COM1, 1,MC_temp);
	    }
	    else
	    {
		MC_temp = 10;
	    }
	    *)
	    call 'MyCond_PannelUnlock'(dv_NI700_COM1, 1);
    }
}


LEVEL_EVENT [vdvCCP_pannel, 1]
{


}
*)
DEFINE_PROGRAM
