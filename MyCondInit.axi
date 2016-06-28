PROGRAM_NAME='MyCondInit'
(*
1,3,20,0,1,0,30,0,19,0,1,0,7,0,1,0,0,0,1,0,0,0,0,140,149
1,3,20,0,1,0,30,0,19,0,1,0,7,0,1,0,0,0,0,0,0,0,0,177,85,0
1,3,20,0,1,0,30,0,19,0,1,0,7,0,1,0,0,0,1,0,0,0,0,140,149
*)


DEFINE_DEVICE
(***********************************************************)
(*                    ПОРТЫ MODBUS                         *)
(***********************************************************)

dvModbus1PhyPort = dv_COM2T_home_Port1;

(***********************************************************)
(*                 ВИРТУАЛЬНЫЕ УСТРОЙСТВА                  *)
(***********************************************************)
vdvModbusPort1 = 33100:1:0;   
vdvMyCondUI1 = 33120:1:0;  
vdvMyCondUI2 = 33121:1:0;  

(*
    структура вирутального девайса
    vdvMyCondUIХ :
	Channel:
		    1 - Включена (1) или выключена (0) панель
		    2 - Заблокирована (1) или не заблокирована (0) панель 
		    3 - Режим "Солнышко"
		    4 - Режим "Снежинка"
		    5 - Режим "Проветривание" (работает не на всех панелях MyCond
		    6 - Скорость проветривания 1
		    7 - Скорость проветривания 2
		    8 - Скорость проветривания 3
		    9 - Скорость проветривания авто
		    10 - Панель онлайн (1) / оффлайн (0)
		    11 - Переключение режимов
		    12 - Переключение скоростей вентилятора
		    13 - Увеличить температуру
		    14 - Уменьшить температуру
	
	Level:
		    1 - Температура установленная пользователем (10 - 30 градусов) ПРИШЛО ОТ ПАНЕЛИ
		    2 - Температура измеренная панелью
		    3 - Температура установленная пользователем (10 - 30 градусов) ПОСЛАТЬ НА ПАНЕЛЬ
*)
DEFINE_CONSTANT
(*
  Индикаторы состояний и кнопки управления
  для первой панели MyCond на тач панеле АМХ
  и соответствующие каналы (уровни)
  виртуального устройства vdvMyCondUI1
*)
DEVCHAN TP_UI1_POWER_BTN = {dv_TP_control_pannel, 30};
DEVCHAN UI1_POWER_ST = {vdvMyCondUI1, 1};
DEVCHAN TP_UI1_LOCK_BTN = {dv_TP_control_pannel, 31};
DEVCHAN UI1_LOCK_ST = {vdvMyCondUI1, 2};
DEVCHAN TP_UI1_SUN = {dv_TP_control_pannel, 32};
DEVCHAN UI1_SUN = {vdvMyCondUI1, 3};
DEVCHAN TP_UI1_SNOW = {dv_TP_control_pannel, 33};
DEVCHAN UI1_SNOW = {vdvMyCondUI1, 4};
DEVCHAN TP_UI1_F_S_1 = {dv_TP_control_pannel, 36};
DEVCHAN UI1_F_S1 = {vdvMyCondUI1, 6};
DEVCHAN TP_UI1_F_S_2 = {dv_TP_control_pannel, 37};
DEVCHAN UI1_F_S2 = {vdvMyCondUI1, 7};
DEVCHAN TP_UI1_F_S_3 = {dv_TP_control_pannel, 38};
DEVCHAN UI1_F_S3 = {vdvMyCondUI1, 8};
DEVCHAN TP_UI1_F_S_AUTO = {dv_TP_control_pannel, 39};
DEVCHAN UI1_F_S_AUTO = {vdvMyCondUI1, 9};
DEVCHAN TP_UI1_ONLINE = {dv_TP_control_pannel, 40};
DEVCHAN UI1_ONLINE = {vdvMyCondUI1, 10};

DEVCHAN TP_UI1_MODE_SELECT_BTN = {dv_TP_control_pannel, 34};
DEVCHAN UI1_MODE_SELECT = {vdvMyCondUI1, 11};
DEVCHAN TP_UI1_F_SP_SELECT_BTN = {dv_TP_control_pannel, 35};
DEVCHAN UI1_F_SP_SELECT = {vdvMyCondUI1, 12};
DEVCHAN TP_UI1_T_S_PLUS_BTN = {dv_TP_control_pannel, 42};
DEVCHAN UI1_T_S_PLUS = {vdvMyCondUI1, 13};
DEVCHAN TP_UI1_T_S_MINUS_BTN = {dv_TP_control_pannel, 41};
DEVCHAN UI1_T_S_MINUS = {vdvMyCondUI1, 14};

DEVLEV TP_UI1_T_M = {dv_TP_control_pannel, 30};
DEVLEV UI1_T_M = {vdvMyCondUI1, 2};
DEVLEV TP_UI1_T_S = {dv_TP_control_pannel, 31};
DEVLEV UI1_T_S = {vdvMyCondUI1, 1};



(*
  Индикаторы состояний и кнопки управления 
  для второй панели MyCond на тач панеле АМХ
  и соответствующие каналы (уровни)
  виртуального устройства vdvMyCondUI2
*)
DEVCHAN TP_UI2_POWER_BTN = {dv_TP_control_pannel, 10};
DEVCHAN UI2_POWER_ST = {vdvMyCondUI2, 1};
DEVCHAN TP_UI2_LOCK_BTN = {dv_TP_control_pannel, 11};
DEVCHAN UI2_LOCK_ST = {vdvMyCondUI2, 2};
DEVCHAN TP_UI2_SUN = {dv_TP_control_pannel, 12};
DEVCHAN UI2_SUN = {vdvMyCondUI2, 3};
DEVCHAN TP_UI2_SNOW = {dv_TP_control_pannel, 13};
DEVCHAN UI2_SNOW = {vdvMyCondUI2, 4};
DEVCHAN TP_UI2_F_S_1 = {dv_TP_control_pannel, 16};
DEVCHAN UI2_F_S1 = {vdvMyCondUI2, 6};
DEVCHAN TP_UI2_F_S_2 = {dv_TP_control_pannel, 17};
DEVCHAN UI2_F_S2 = {vdvMyCondUI2, 7};
DEVCHAN TP_UI2_F_S_3 = {dv_TP_control_pannel, 18};
DEVCHAN UI2_F_S3 = {vdvMyCondUI2, 8};
DEVCHAN TP_UI2_F_S_AUTO = {dv_TP_control_pannel, 19};
DEVCHAN UI2_F_S_AUTO = {vdvMyCondUI2, 9};
DEVCHAN TP_UI2_ONLINE = {dv_TP_control_pannel, 20};
DEVCHAN UI2_ONLINE = {vdvMyCondUI2, 10};

DEVCHAN TP_UI2_MODE_SELECT_BTN = {dv_TP_control_pannel, 14};
DEVCHAN UI2_MODE_SELECT = {vdvMyCondUI2, 11};
DEVCHAN TP_UI2_F_SP_SELECT_BTN = {dv_TP_control_pannel, 15};
DEVCHAN UI2_F_SP_SELECT = {vdvMyCondUI2, 12};
DEVCHAN TP_UI2_T_S_PLUS_BTN = {dv_TP_control_pannel, 22};
DEVCHAN UI2_T_S_PLUS = {vdvMyCondUI2, 13};
DEVCHAN TP_UI2_T_S_MINUS_BTN = {dv_TP_control_pannel, 21};
DEVCHAN UI2_T_S_MINUS = {vdvMyCondUI2, 14};

DEVLEV TP_UI2_T_M = {dv_TP_control_pannel, 10};
DEVLEV UI2_T_M = {vdvMyCondUI2, 2};
DEVLEV TP_UI2_T_S = {dv_TP_control_pannel, 11};
DEVLEV UI2_T_S = {vdvMyCondUI2, 1};

DEFINE_VARIABLE

volatile char OutgoingModbusBuffer[10][8];

//Pannel ID = 1;
volatile char Pannel_1_ID = 1;
volatile char IgnoreNewVal_P1 = 0;
non_volatile char MycondPan1OldStates [6] = {0,0,0,0,0,0};
non_volatile char MycondPan1NewStates [6] = {0,0,0,0,0,0};
(*
Структура массива MycondPanХOldStates:
		    1 - Включена (1) или выключена (0) панель или нет связи (2)
		    2 - Режим работы панели (1 - Снежинка, 2 - Солнышко, 3 - Вентиляция)
		    3 - Скорость вентилятора (1 - первая, 2 - вторая, 3 - третья, 4..6 - авто)
		    4 - Температура измеренная панелью
		    5 - Температура установленная на панели
		    6 - заблокирована ли панель?
*)


//Pannel ID = 2;
volatile char Pannel_2_ID = 2;
volatile char IgnoreNewVal_P2 = 0;
non_volatile char MycondPan2OldStates [6] = {0,0,0,0,0,0};
non_volatile char MycondPan2NewStates [6] = {0,0,0,0,0,0};

//массив виртуальных девайсов (vdvMyCondUI) 
//для панелей подклюенных к одной шине ModBus 
volatile DEV vdvMyCondOnBus_1_UI[] = 
{
    vdvMyCondUI1,
    vdvMyCondUI2
};

volatile char MycondModbus_1_AnswerWaitFlag = 0;  //флаг с номером девайса от которого ждем ответ
volatile char ModBus_1_updateTime = 20;   //Время опроса шины
volatile char ModBus_1_TimeOutTime = 10;   //Время таймаута одногоустройства на шине
//Модуль шины
DEFINE_MODULE 'MyCondModbus' mdlMycondBUS_1 (
						dvModbus1PhyPort, 
						vdvModbusPort1, 
						vdvMyCondOnBus_1_UI, 
						OutgoingModbusBuffer, 
						MycondModbus_1_AnswerWaitFlag,
						ModBus_1_updateTime,
						ModBus_1_TimeOutTime);
//Модули панелей
DEFINE_MODULE 'MyCondUI' mdlMycondUI_1 (
					    vdvMyCondUI1, 
					    vdvModbusPort1, 
					    Pannel_1_ID, 
					    MycondPan1OldStates, 
					    MycondPan1NewStates,
					    IgnoreNewVal_P1);
DEFINE_MODULE 'MyCondUI' mdlMycondUI_2 (
					    vdvMyCondUI2, 
					    vdvModbusPort1, 
					    Pannel_2_ID, 
					    MycondPan2OldStates, 
					    MycondPan2NewStates,
					    IgnoreNewVal_P2);

DEFINE_EVENT
DATA_EVENT[vdvMyCondUI1]
{ 
    ONLINE:
    {
	wait 10	
	{
	    //Комбайны каналов и левелов виртуального устройства и тач панели амх
	    COMBINE_CHANNELS (UI1_POWER_ST, TP_UI1_POWER_BTN);
	    COMBINE_CHANNELS (UI1_LOCK_ST, TP_UI1_LOCK_BTN);
	    COMBINE_CHANNELS (UI1_SUN, TP_UI1_SUN);
	    COMBINE_CHANNELS (UI1_SNOW, TP_UI1_SNOW);
	    COMBINE_CHANNELS (UI1_F_S1, TP_UI1_F_S_1);
	    COMBINE_CHANNELS (UI1_F_S2, TP_UI1_F_S_2);
	    COMBINE_CHANNELS (UI1_F_S3, TP_UI1_F_S_3);
	    COMBINE_CHANNELS (UI1_F_S_AUTO, TP_UI1_F_S_AUTO);
	    COMBINE_CHANNELS (UI1_ONLINE, TP_UI1_ONLINE);
	    COMBINE_CHANNELS (UI1_LOCK_ST, TP_UI1_LOCK_BTN);
	    COMBINE_CHANNELS (UI1_MODE_SELECT, TP_UI1_MODE_SELECT_BTN);
	    COMBINE_CHANNELS (UI1_F_SP_SELECT, TP_UI1_F_SP_SELECT_BTN);
	    COMBINE_CHANNELS (UI1_T_S_PLUS, TP_UI1_T_S_PLUS_BTN);
	    COMBINE_CHANNELS (UI1_T_S_MINUS, TP_UI1_T_S_MINUS_BTN);
	    COMBINE_LEVELS (UI1_T_M, TP_UI1_T_M);
	    COMBINE_LEVELS (UI1_T_S, TP_UI1_T_S);
	}
    }
}

DATA_EVENT[vdvMyCondUI2]
{ 
    ONLINE:
    {
	wait 15	
	{
	    //Комбайны каналов и левелов виртуального устройства и тач панели амх
	    COMBINE_CHANNELS (UI2_POWER_ST, TP_UI2_POWER_BTN);
	    COMBINE_CHANNELS (UI2_LOCK_ST, TP_UI2_LOCK_BTN);
	    COMBINE_CHANNELS (UI2_SUN, TP_UI2_SUN);
	    COMBINE_CHANNELS (UI2_SNOW, TP_UI2_SNOW);
	    COMBINE_CHANNELS (UI2_F_S1, TP_UI2_F_S_1);
	    COMBINE_CHANNELS (UI2_F_S2, TP_UI2_F_S_2);
	    COMBINE_CHANNELS (UI2_F_S3, TP_UI2_F_S_3);
	    COMBINE_CHANNELS (UI2_F_S_AUTO, TP_UI2_F_S_AUTO);
	    COMBINE_CHANNELS (UI2_ONLINE, TP_UI2_ONLINE);
	    COMBINE_CHANNELS (UI2_LOCK_ST, TP_UI2_LOCK_BTN);
	    COMBINE_CHANNELS (UI2_MODE_SELECT, TP_UI2_MODE_SELECT_BTN);
	    COMBINE_CHANNELS (UI2_F_SP_SELECT, TP_UI2_F_SP_SELECT_BTN);
	    COMBINE_CHANNELS (UI2_T_S_PLUS, TP_UI2_T_S_PLUS_BTN);
	    COMBINE_CHANNELS (UI2_T_S_MINUS, TP_UI2_T_S_MINUS_BTN);
	    COMBINE_LEVELS (UI2_T_M, TP_UI2_T_M);
	    COMBINE_LEVELS (UI2_T_S, TP_UI2_T_S);
	}
    }
}




