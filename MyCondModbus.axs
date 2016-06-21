MODULE_NAME='MyCondModbus'(DEV PhyModbusPort, DEV vdvModbusPort, DEV vdvMyCondOnBusUI[], char DEBUGSTR1[], char DEBUGSTR2[], char TimeoutFlag, char CMD_SENT_FLAG)
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

volatile DEV vdvTempMyCondPannel = 0:0:0;
volatile char MyCondCommand[6] = {$00,$00,$00,$00,$00,$00};
volatile char ModBusPacket[8] = {$00,$00,$00,$00,$00,$00,$00,$00};
volatile char PanId_Awaiting = 0;
volatile char CMD_ToVdvMC_UI [6] = {0,0,0,0,0,0};
volatile char MyCondPannelQuantyAtPort = 0;
volatile char GetPannelDataFlag = 0;
volatile char GetPannelDataId = 0;
volatile char LastCmdSent [8];
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

(* Расчет контрольной суммы для пакета из 6ти байт посылки Модбас *)
DEFINE_FUNCTION NEW_CRC16 (char Packet[6], char MB_PACKET[8])
{	
(* Packet[6] - входные данные, 
MODBUS_PACKET[8] - выходные 
(посылка с контрольной суммой) *)
    CHAR TEMP[6]
    //CHAR MODBUS_PACKET[8]
    LONG TEMP_1
    LONG XFLG
    LONG I
    LONG J
    LONG CRC
    TEMP = Packet
    //TEMP = "$01,$06,$00,$04,$00,$01"
    CRC = $FFFF
    FOR(I=1;I<7;I++)
    {
	TEMP_1 = TEMP[I]
	FOR(J=1;J<9;J++)
	{
	    XFLG = (CRC^TEMP_1) & $0001
	    CRC = CRC >> 1
	    IF(XFLG<>0)
	    {
		CRC = CRC ^ $A001
	    }
	    TEMP_1 = TEMP_1 / 2
	}
    }
    I = CRC / 256
    J = CRC - (I*256)
    MB_PACKET = "TEMP,J,I"
}


//запрос на получение данных с панели
define_call 'MyCond_GetPannelData'(DEV MB_PORT, char PanId)
{
    	TimeoutFlag = 1;
	GetPannelDataFlag = 1;
	vdvTempMyCondPannel = vdvMyCondOnBusUI[PanId];
	MyCondCommand = "PanId,$03,$00,$00,$00,$0a"; 
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;
	wait 20 'RecieveTimeout'
	{
	    send_string 0, "'MB ERROR P',itoa(PanId),' TIMEOUT'";
	    send_command vdvTempMyCondPannel, "'PANNEL_OFFLINE'";
	    TimeoutFlag = 0;
	    if(PanId < MyCondPannelQuantyAtPort)
	    {
		GetPannelDataId=PanId+1;
		CALL 'MyCond_GetPannelData'(PhyModbusPort, GetPannelDataId);	    
	    }
	}
}

//запрос на включение панели
define_call 'MyCond_PannelOn'(dev MB_PORT, char PanId)
{
	MyCondCommand = "PanId,$06,$00,$00,$00,$01"; 
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;
}

//запрос на выключение панелли
define_call 'MyCond_PannelOff'(dev MB_PORT, char PanId)
{
	MyCondCommand = "PanId,$06,$00,$00,$00,$00"; 
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;

}

//запрос на блокировку панели
define_call 'MyCond_PannelLock'(dev MB_PORT, char PanId)
{
	MyCondCommand = "PanId,$06,$00,$07,$00,$01"; 
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;

}

//запрос на разблокировку панели
define_call 'MyCond_PannelUnlock'(dev MB_PORT, char PanId)
{

	MyCondCommand = "PanId,$06,$00,$07,$00,$00"; 
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;

}

//запрос на установку необходимого значения скорости вентилятора
define_call 'MyCond_SetFanSpeed'(dev MB_PORT, char PanId, char PanSpeed)
{
	switch(PanSpeed)
	{
	    case 1:
	    {
		MyCondCommand = "PanId,$06,$00,$04,$00,$01"; 
		break;
	    }
	    case 2:
	    {
		MyCondCommand = "PanId,$06,$00,$04,$00,$02"; 
		break;
	    }
	    case 3:
	    {
		MyCondCommand = "PanId,$06,$00,$04,$00,$03"; 
		break;
	    }
	    case 4:
	    {
		MyCondCommand = "PanId,$06,$00,$04,$00,$06"; 
		break;
	    }
	}
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;
}


//запрос на установку необходимого режима работы панели
define_call 'MyCond_SetMode'(dev MB_PORT, char PanId, char PanMode)
{
	switch(PanMode)
	{
	    case 1://охлаждение (снежинка)
	    {
		MyCondCommand = "PanId,$06,$00,$03,$00,$01"; 
		break;
	    }
	    case 2://отопление  (солнышко)
	    {
		MyCondCommand = "PanId,$06,$00,$03,$00,$02"; 
		break;
	    }
	    case 3://вентиляция  - на панели не реализуется, не понятно откуда он вообще в инструкции взялся
	    {
		MyCondCommand = "PanId,$06,$00,$03,$00,$03"; 
		break;
	    }
	}
	NEW_CRC16 (MyCondCommand, ModBusPacket);
	SEND_STRING MB_PORT,ModBusPacket;
	LastCmdSent = ModBusPacket;
}



//Запрос на установку температуры на панель
define_call 'MyCond_SetTemperature'(dev MB_PORT, char PanId, char PanTemp)
{
	if((PanTemp>9)&&(PanTemp<31))
	{
	    MyCondCommand = "PanId,$06,$00,$02,$00,PanTemp";
	    NEW_CRC16 (MyCondCommand, ModBusPacket);
	    SEND_STRING MB_PORT,ModBusPacket;
	    LastCmdSent = ModBusPacket;
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


DATA_EVENT[PhyModbusPort]
{ 
    ONLINE:
    {
	//IF Port is NI processor PHY Port
	SEND_COMMAND data.device, 'SET BAUD 9600,N,8,1 485 ENABLE';
	
	
	// Set number of pannels on bus
	MyCondPannelQuantyAtPort = MAX_LENGTH_ARRAY (vdvMyCondOnBusUI);
    }
    STRING:
    {
	DEBUGSTR1 = ModBusPacket;
	DEBUGSTR2 = data.text;
	if((GetPannelDataFlag > 0)&&(LastCmdSent[1] == Data.Text[1])&&(LastCmdSent[2] == Data.Text[2]))
	{
	    cancel_wait 'RecieveTimeout';
	    TimeoutFlag = 0;
	    GetPannelDataFlag = 0;
	    CMD_ToVdvMC_UI [1]  = Data.Text[5]; //Включены или выключена
	    CMD_ToVdvMC_UI [2]  = Data.Text[11]; //Режим установленный на панели
	    CMD_ToVdvMC_UI [3]  = Data.Text[13];  //Скорость вентилятора
	    CMD_ToVdvMC_UI [4]  = Data.Text[7];  //Температура измеренная панелью
	    CMD_ToVdvMC_UI [5]  = Data.Text[9];  //Температура установленная на панели
	    CMD_ToVdvMC_UI [6]  = Data.Text[19];  //Панель заблокирована (1) и нет (0)
	    (*if ( GetPannelDataId == 1 )
	    {
		DEBUGSTR = Data.Text;
	    }*)
	    send_command vdvTempMyCondPannel, "'PANNEL_ONLINE'";
	    //send_string 0, "'MB P',itoa(PanId),' ONLINE'";
	    SEND_COMMAND vdvTempMyCondPannel,"'NEW_DATA:',CMD_ToVdvMC_UI [1],CMD_ToVdvMC_UI [2],CMD_ToVdvMC_UI [3],CMD_ToVdvMC_UI [4],CMD_ToVdvMC_UI [5],CMD_ToVdvMC_UI [6]";
	    
	    if(GetPannelDataId < MyCondPannelQuantyAtPort)
	    {
		GetPannelDataId++;
		CALL 'MyCond_GetPannelData'(data.device, GetPannelDataId);	    
	    }
	    else
	    {
		TimeoutFlag = 0;
	    }
	}
    }	
}

DATA_EVENT[vdvModbusPort]
{ 
    (*ONLINE:
    {
    }*)
    COMMAND:
    {
	char CMD[50];
	char PanIdChar[2];
	SELECT
	{
	    ACTIVE(FIND_STRING(data.text,'SET_MODE_',1)): //SET_MODE_1_PAN_ID_1
	    {
		char PanMode[2];
		CMD = data.text;
		REMOVE_STRING (CMD,'SET_MODE_',1);
		PanMode = LEFT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)));
		REMOVE_STRING (CMD,'_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_SetMode'(PhyModbusPort, atoi(PanIdChar), atoi(PanMode));
	    }
	    ACTIVE(FIND_STRING(data.text,'SET_FAN_SPEED_',1)):  //SET_FAN_SPEED_1_PAN_ID_1
	    {
		char FanSpeed[2];
		CMD = data.text;
		REMOVE_STRING (CMD,'SET_FAN_SPEED_',1);
		FanSpeed = LEFT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)));
		REMOVE_STRING (CMD,'_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_SetFanSpeed'(PhyModbusPort, atoi(PanIdChar), atoi(FanSpeed));
	    }
	    ACTIVE(FIND_STRING(data.text,'SET_PAN_TEMP_',1)):  //SET_PAN_TEMP_25_PAN_ID_1
	    {
		char PanTemp[2];
		CMD = data.text;
		REMOVE_STRING (CMD,'SET_PAN_TEMP_',1);
		//send_string 0, "CMD";
		PanTemp = LEFT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)));
		//send_string 0, "'T=',PanTemp";
		REMOVE_STRING (CMD,'_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		//send_string 0, "'ID=',PanIdChar";
		CALL 'MyCond_SetTemperature'(PhyModbusPort, atoi(PanIdChar), atoi(PanTemp));
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_ON',1)):  //PANNEL_ON_PAN_ID_1
	    {
		CMD = data.text;
		REMOVE_STRING (CMD,'PANNEL_ON_PAN_ID_',1);
		//REMOVE_STRING (CMD,'_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_PannelOn'(PhyModbusPort, atoi(PanIdChar));
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_OFF',1)):  //PANNEL_OFF_PAN_ID_1
	    {
		CMD = data.text;
		REMOVE_STRING (CMD,'PANNEL_OFF_PAN_ID_',1);
		//REMOVE_STRING (CMD,'_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_PannelOff'(PhyModbusPort, atoi(PanIdChar));
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_LOCK',1)):  //PANNEL_LOCK_PAN_ID_1
	    {
		CMD = data.text;
		REMOVE_STRING (CMD,'PANNEL_LOCK_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_PannelLock'(PhyModbusPort, atoi(PanIdChar));
	    }
	    ACTIVE(FIND_STRING(data.text,'PANNEL_UNLOCK',1)):  //PANNEL_UNLOCK_PAN_ID_1
	    {
		CMD = data.text;
		REMOVE_STRING (CMD,'PANNEL_UNLOCK_PAN_ID_',1);
		PanIdChar = CMD;
		//PanIdChar = RIGHT_STRING(CMD,(FIND_STRING(CMD,'_PAN_ID_',1)+8));
		CALL 'MyCond_PannelUnlock'(PhyModbusPort, atoi(PanIdChar));
	    }
	    ACTIVE(FIND_STRING(data.text,'UPDATE_PANNEL_DATA',1)):
	    {
		GetPannelDataId = 1;
		CALL 'MyCond_GetPannelData'(PhyModbusPort, GetPannelDataId);
	    }
	}	
	
    }
}


(***********************************************************)
(*            THE ACTUAL PROGRAM GOES BELOW                *)
(***********************************************************)
DEFINE_PROGRAM


wait 50 'UpdatePannelData_MB_1'
{
    if((TimeoutFlag == 0))
    {
	SEND_COMMAND vdvModbusPort, "'UPDATE_PANNEL_DATA'";
    }
}


(***********************************************************)
(*                     END OF PROGRAM                      *)
(*        DO NOT PUT ANY CODE BELOW THIS COMMENT           *)
(***********************************************************)
