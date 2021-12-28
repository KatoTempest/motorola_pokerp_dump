#!/system/bin/sh
#!/bin/bash

# Copyright (C) 2019 Lenovo Company, Inc.
# All Rights Reserved
# Edited By Rafael Venturini 
# Date 03/28/2019

# Please provide implementation for all the functions below.

version=0.1
Default_Delay=5
Default_FM_freq=975
Default_DTV_CHAN=45

#####################################################################
# Function:    BATT_CHARGE_DISABLE					           		#
# Description: This function should force Android to disable the    #
#			   phone charging even with USB cable connected. 	    #
#	     Note: Important is to guarantee that not only the charging # 
#              icon has changed, but energy is not flowing to 		#
#			   battery to charge it.								#
# Inputs:      N/A										   		    #
# Output:      status: 	OK/ERROR   						   		    #
#####################################################################
function BATT_CHARGE_DISABLE
{
    echo "0" > "/sys/class/power_supply/charger/charge_enabled"
    echo "RETURN=PASS"
}


#####################################################################
# Function:    BATT_CHARGE_ENABLE					           	    #
# Description: This function should re-enable the phone charging    #
# Inputs:      N/A										   		    #
# Output:      status: 	OK/ERROR   						   		    #
#####################################################################
function BATT_CHARGE_ENABLE
{
    echo "1" > "/sys/class/power_supply/charger/charge_enabled"
    echo "RETURN=PASS"
}

#####################################################################
# Function:    BATT_CURRENT_READ_INSTANT				            #
# Description: This function should provide the real-time current   #
#			   flow on the phone battery.							#
#        Note: It is very important that the current value returned #
#              is as real-time as possible. This function will be   #
#		       called multiple times to measure stability           #
# Inputs:      N/A										   		    #
# Output:      OK,[battery current mA]/ERROR   			   			#
#####################################################################
function BATT_CURRENT_READ_INSTANT
{
    RET=$(cat sys/class/power_supply/battery/current_now)
    echo $RET
}

#####################################################################
# Function:    BATT_CURRENT_READ_AVERAGE				            #
# Description: This function should provide the average current     #
#			   flowing on the phone battery.						#
#        Note: This value should be updated periodically according  #
#              last current measures							    #
# Inputs:      N/A										   		    #
# Output:      OK,[battery current mA]/ERROR  			 			#
#####################################################################
function BATT_CURRENT_READ_AVERAGE
{	
    RET=$(cat sys/class/power_supply/battery/current_avg)
    echo $RET
}

#####################################################################
# Function:    BATT_BATTERY_THERMISTOR   				            #
# Description: This function should provide the battery thermistor  #
#			   value in DACs			   .						#
#        Note: This value should be updated periodically  		    #
# Inputs:      N/A										   		    #
# Output:      OK,[thermistor value]/ERROR  		 				#
#####################################################################
function BATT_BATTERY_THERMISTOR
{	
    RET=$(cat sys/class/power_supply/battery/temp)
    echo $RET
}
##### Read Batt Current - END #####

#####################################################################
# Function:    SWITCH_TO_BATTERY    	   				            #
# Description: This function should force the current draw from the #
#			   phone Charger Supply to the Battery Power Supply     #
# Inputs:      N/A										   		    #
# Output:      status: 	OK/ERROR   						   		    #
#####################################################################
function SWITCH_TO_BATTERY
{	
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

#####################################################################
# Function:    SWITCH_TO_BATTERY    	   				            #
# Description: This function should force the current draw from the #
#			   phone Battery Power Supply to the Charger Supply     #
# Inputs:      N/A										   		    #
# Output:      status: 	OK/ERROR   						   		    #
#####################################################################
function SWITCH_TO_ACCESSORY
{	
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    DTV_ON    								   		  #
# Description: This function should Enable the DTV module  		  #
#              and sync the default channel				   		  #
#        Note: no splash screen or prompt box should be required  #
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function DTV_ON
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
	
}

###################################################################
# Function:    DTV_TUNE    								      	  #
# Description: This function should sync the specified DTV    	  #
#              channel passed as input on this function call  	  #
# Inputs:      Desired DTV Channel						      	  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function DTV_TUNE
{
	# takes argument
	# insert your code below
    echo "parameter received: $1"
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
	
}

###################################################################
# Function:    DTV_MEAS    								  		  #
# Description: This function should return the DTV Carrier   	  #
#              Noise (CN) value for the sync channel	   		  #
# Inputs:      N/A										   		  #
# Output:      OK,[DTV CN]/ERROR   						   		  #
###################################################################
function DTV_MEAS
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
	
}

###################################################################
# Function:    DTV_OFF    								   		  #
# Description: This function should disable the DTV module 		  #
#        Note: terminate any DTV process				     	  # 
# Inputs:      N/A										  		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function DTV_OFF
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
	
}

###################################################################
# Function:    FM_ON    								   	  	  #
# Description: This function should enable the FM module   		  #
#              and sync default frequency of 97.5Mhz              #
#        Note: no splash screen or prompt box should be required  #
# Inputs:      N/A										   		  # 
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function FM_ON
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_ON
	
    sleep 1
    FM_ON="FAIL"
    for i in $(seq 40 -1 1)
    do
    if [ $(getprop persist.sys.FM_STATE) -eq 1 ];then
    FM_ON="OK"
    echo "RETURN=PASS"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_ON = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi
	
}

###################################################################
# Function:    FM_TUNE    								   		  #
# Description: This function should sync a desired freq passed as #
#              input on this function call              		  #
# Inputs:      Desired FM freq							   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function FM_TUNE
{
	# takes argument
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_TUNE --es CQA_TEST_PARAMS $1
	
	  sleep 1
    FM_TUNE="FAIL"
    for i in $(seq 3 -1 1)
    do
    if [ $(getprop persist.sys.FM_TuneState) -eq 1 ];then
    echo "parameter received: $1"
    echo "RETURN=PASS"
    FM_TUNE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_TUNE = "FAIL" ];then
    echo "parameter received: $1"
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi	
	
}

###################################################################
# Function:    FM_GETRSSI  								   		  #
# Description: This function should return the FM RSSI     		  #
#        Note: The RSSI should be updated periodically or on      # 
#			   every call of function FM_GETRSSI	    	      #    
# Inputs:      N/A										   		  #
# Output:      OK,[FM rssi]/ERROR  			 			   		  #
###################################################################
function FM_GETRSSI
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_GETRSSI

    sleep 1
    FM_GETRSSI="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.RSSI_VALUE) -ne 0 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.RSSI_VALUE)]"
    FM_GETRSSI="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_GETRSSI = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi	
    
    
}

###################################################################
# Function:    FM_OFF    								   		  #
# Description: This function should disable the FM module  		  #
#        Note: terminate any FM process				       		  # 
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function FM_OFF
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FM --es CQA_TEST_FUNCTION FM_OFF
    
    sleep 1
    FM_OFF="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.FM_STATE) -eq 0 ];then
    FM_OFF="OK"
    echo "RETURN=PASS"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_OFF = "FAIL" ];then
    echo "RETURN=ERROR"		
    echo "feature $0 not implemented"		
    fi
	
}

###################################################################
# Function:    FM_CHECK    									      #
# Description: This function should check FM (SOC or not.)#
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function FM_CHECK
{
    sleep 1
    FM_CHECK="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FTMFM_state) -eq 1 ];then
    echo "RETURN=PASS"
    FM_CHECK="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FM_CHECK = "FAIL" ];then
    echo "RETURN=ERROR"			
    fi
}

###################################################################
# Function:    LED_RED    								          #
# Description: This function should enable the RED not. Led       #
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_RED
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE LED --es CQA_TEST_FUNCTION LED_RED
    sleep 1
  #  LED_RED="FAIL"
  #  for i in $(seq 10 -1 1)
  #  do
  #  if [ $(getprop persist.sys.LED_RED) -eq 1 ];then
  #  LED_RED="OK"
  #  echo "RETURN=PASS"
  #  break
  #  else	
  #  echo "wait..."
  #  fi
  #  sleep 1
  #  done
  #  if [ $LED_RED = "FAIL" ];then
  #  echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
  #  fi
}

###################################################################
# Function:    LED_GREEN    								      #
# Description: This function should enable the green not. Led     #
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_GREEN
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE LED --es CQA_TEST_FUNCTION LED_GREEN
    sleep 1
  #  LED_GREEN="FAIL"
  #  for i in $(seq 10 -1 1)
  #  do
  #  if [ $(getprop persist.sys.LED_GREEN) -eq 1 ];then
  #  LED_GREEN="OK"
  #  echo "RETURN=PASS"
  #  break
  #  else	
  #  echo "wait..."
  #  fi
  #  sleep 1
  #  done
  #  if [ $LED_GREEN = "FAIL" ];then
  #  echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
  #  fi
}

###################################################################
# Function:    LED_BLUE    									      #
# Description: This function should enable the blue not. Led      #
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_BLUE
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
}

###################################################################
# Function:    LED_SOC    									      #
# Description: This function should enable the SOC Led   	      #
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_SOC
{
    # insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"
	
}

###################################################################
# Function:    LED_OFF    									      #
# Description: This function should disable all leds (SOC or not.)#
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_OFF
{
    # insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE LED --es CQA_TEST_FUNCTION LED_OFF
  #  sleep 1
  #  LED_OFF="FAIL"
  #  for i in $(seq 10 -1 1)
  #  do
  #  if [ $(getprop persist.sys.LED_OFF) -eq 1 ];then
  #  LED_OFF="OK"
  #  echo "RETURN=PASS"
  #  break
  #  else	
  #  echo "wait..."
  #  fi
  #  sleep 1
  #  done
  #  if [ $LED_OFF = "FAIL" ];then
  #  echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
  #  fi
}

###################################################################
# Function:    LED_CHECK    									      #
# Description: This function should check leds (SOC or not.)#
# Inputs:      N/A										   		  #
# Output:      status: 	OK/ERROR   						   		  #
###################################################################
function LED_CHECK
{
    sleep 1
    LED_CHECK="FAIL"
    for i in $(seq 3 -1 1)
    do
    if [ $(getprop persist.sys.Led_state) -eq 1 ];then
    echo "RETURN=PASS"
    LED_CHECK="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $LED_CHECK = "FAIL" ];then
    echo "RETURN=ERROR"			
    fi
}

####################################################################
# Function:    MIC_1_TOHEADSETRECV_ON					           #
# Description: This function should enable loopback between MIC1   #
#			   and headset Receivers. 							   #
#        Note: This loopack should be LIVE. It means that it's not #
#              recommended record the MIC and playback on receiver #
#			   because this results in delays that is not allowed  # 
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function MIC_1_TOHEADSETRECV_ON
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_1_TOHEADSETRECV_ON
    sleep 0.5
    MIC_1_TOHEADSETRECV_ON="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic1_headset_state) -eq 1 ];then
    echo "RETURN=PASS"
    MIC_1_TOHEADSETRECV_ON="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_1_TOHEADSETRECV_ON = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi			
}

####################################################################
# Function:    MIC_1_TOHEADSETRECV_OFF					           #
# Description: This function should disable loopback between MIC1  #
#			   and headset Receivers. 							   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function MIC_1_TOHEADSETRECV_OFF
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_1_TOHEADSETRECV_OFF
    sleep 0.5
    MIC_1_TOHEADSETRECV_OFF="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic1_headset_state) -eq 0 ];then
    echo "RETURN=PASS"
    MIC_1_TOHEADSETRECV_OFF="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_1_TOHEADSETRECV_OFF = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    MIC_2_TOHEADSETRECV_ON					           #
# Description: This function should enable loopback between MIC2   #
#			   and headset Receivers. 							   #
#        Note: This loopack should be LIVE. It means that it's not #
#              recommended record the MIC and playback on receiver #
#			   because this results in delays that is not allowed  # 
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function MIC_2_TOHEADSETRECV_ON
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_2_TOHEADSETRECV_ON
    sleep 0.5
    MIC_2_TOHEADSETRECV_ON="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic2_headset_state) -eq 1 ];then
    echo "RETURN=PASS"
    MIC_2_TOHEADSETRECV_ON="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_2_TOHEADSETRECV_ON = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    MIC_2_TOHEADSETRECV_OFF					           #
# Description: This function should disable loopback between MIC2  #
#			   and headset Receivers. 							   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function MIC_2_TOHEADSETRECV_OFF
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE MIC --es CQA_TEST_FUNCTION MIC_2_TOHEADSETRECV_OFF
    sleep 0.5
    MIC_2_TOHEADSETRECV_OFF="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop vendor.audiohal.mic2_headset_state) -eq 0 ];then
    echo "RETURN=PASS"
    MIC_2_TOHEADSETRECV_OFF="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $MIC_2_TOHEADSETRECV_OFF = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    AUDIO_CAL					           		       #
# Description: This function should perform all audio calibration  #
#			   routine if required (in case of use NXP Smart PA    #
#              chipset for example) and return the cal data like   #
#              impedance, temperature, freq or diff				   #
# Inputs:      N/A										   		   #
# Output:      OK,[cal data #comma delimited]/ERROR  			   # 
####################################################################
function AUDIO_CAL
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

########################################################################
# Function:    AUDIO_INTERRUPT_LINE						           	   #
# Description: This function should check the connection for the       #
#		       DSP interrupt line to AP for Always on Voice (AOV Line) #
# Inputs:      N/A										   		   	   #
# Output:      status: 	OK/ERROR   						   		       # 
########################################################################
function AUDIO_INTERRUPT_LINE
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    SENSOR_CAL_ACCEL				           		       #
# Description: This function should perform the accell sensor      #
#			   calibration if required.							   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_ACCEL
{
	# insert your code below
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_ACCEL
    sleep 1
    SENSOR_CAL_ACCEL="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_ACCEL) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_ACCEL="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_ACCEL = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_GYRO				           		       #
# Description: This function should perform the gyroscope sensor   #
#			   calibration if required.							   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_GYRO
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY				          	       #
# Description: This function should perform the proximity sensor   #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_PROXIMITY
{
	# insert your code below
	  am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_PROXIMITY
    sleep 1
    SENSOR_CAL_PROXIMITY="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_NOISE         	       #
# Description: This function should perform the proximity sensor   #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_PROXIMITY_NOISE
{
	# insert your code below
	  am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_PROXIMITY_NOISE
    sleep 1
    SENSOR_CAL_PROXIMITY_NOISE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY_NOISE) -ne 0 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SENSOR_CAL_PROXIMITY_NOISE)]"
    SENSOR_CAL_PROXIMITY_NOISE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY_NOISE = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_3M_5M_M       	       #
# Description: This function should perform the proximity sensor   #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_PROXIMITY_3M_5M_M
{
	# insert your code below
	  am broadcast -a com.ape.factory.SENSOR_CAL_ACTION --es SENSOR_CAL "SENSOR_CAL_PROXIMITY_3M_5M_M"
    sleep 1
    SENSOR_CAL_PROXIMITY_3M_5M_M="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY_3M_5M_M) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY_3M_5M_M="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY_3M_5M_M = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_3M_T       	       #
# Description: This function should perform the proximity sensor   #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_PROXIMITY_3M_T
{
	# insert your code below
	  am broadcast -a com.ape.factory.SENSOR_CAL_ACTION --es SENSOR_CAL "SENSOR_CAL_PROXIMITY_3M_T"
    sleep 1
    SENSOR_CAL_PROXIMITY_3M_T="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY_3M_T) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY_3M_T="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY_3M_T = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_PROXIMITY_5M_T       	       #
# Description: This function should perform the proximity sensor   #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_PROXIMITY_5M_T
{
	# insert your code below
	  am broadcast -a com.ape.factory.SENSOR_CAL_ACTION --es SENSOR_CAL "SENSOR_CAL_PROXIMITY_5M_T"
    sleep 1
    SENSOR_CAL_PROXIMITY_5M_T="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_CAL_PROXIMITY_5M_T) -eq 1 ];then
    echo "RETURN=PASS"
    SENSOR_CAL_PROXIMITY_5M_T="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_CAL_PROXIMITY_5M_T = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    SENSOR_CAL_ALS   				          	       #
# Description: This function should perform the ALS sensor         #
#			   calibration if required.							   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_ALS
{
	# insert your code below
	#am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_CAL_ALS
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    SENSOR_CAL_RF   				          	           #
# Description: This function should perform the calibration of     #
#			   antenna capacitive sensor if required.			   #
#		 Note: If required, this function may be splitted in more  #
#			   blocks and receive or not external parameters	   #
# Inputs:      any external parameter required			   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function SENSOR_CAL_RF
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    SENSOR_PROXIMITY_READ			           		       #
# Description: This function should return the Proximity sensor    #
#			   RAW data value								       #
# Inputs:      N/A										   		   #
# Output:      OK,[Proximity RAW]/ERROR 						   # 
####################################################################
function SENSOR_PROXIMITY_READ
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE SENSOR --es CQA_TEST_FUNCTION SENSOR_PROXIMITY_READ
    sleep 1
    SENSOR_PROXIMITY_READ="FAIL"
    for i in $(seq 15 -1 1)
    do
    if [ $(getprop persist.sys.SENSOR_PROXIMITY_READ) -ne -1 ];then
    echo "RETURN=PASS,[$(getprop persist.sys.SENSOR_PROXIMITY_READ)]"
    SENSOR_PROXIMITY_READ="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $SENSOR_PROXIMITY_READ = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    FINGERPRINT_SELFTEST  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function FINGERPRINT_SELFTEST
{
	# insert your code below
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FINGERPRINT --es CQA_TEST_FUNCTION FINGERPRINT_SELFTEST
    sleep 2
		FINGERPRINT_SELFTEST="FAIL"
    for i in $(seq 20 -1 1)
    do
    if [ $(getprop persist.sys.FINGERPRINT_SELFTEST) -eq 1 ];then
    echo "RETURN=PASS"
    FINGERPRINT_SELFTEST="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 0.5
    done
    if [ $FINGERPRINT_SELFTEST = "FAIL" ];then
    am broadcast -a com.focaltech.fingerprint.activity.CQA --es source "FINGERPRINT_ABSENCE_STOP"
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
    
}

######################################################################
# Function:    FINGERPRINT_PRESENCE  		          	             #
# Description: This function should perform the FPS sensor presence  #
#			   detection test and return PRESENCE/ABSENCE according  #
#			   status of SENSOR		   								 #
#		 Note: It should not require real finger, so the image 	     #
#			   quality test may be removed and performed only sensor #
#			   interrupt test. This test will be performed using 	 #
#			   capacitive finger without fingerprint only flat rubber#
# Inputs:      N/A										   		     #
# Output:      PRESENCE/ABSENCE   						   		     # 
######################################################################
function FINGERPRINT_PRESENCE
{
	# insert your code below
    #am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FINGERPRINT --es CQA_TEST_FUNCTION FINGERPRINT_PRESENCE
    am broadcast -a com.focaltech.fingerprint.activity.CQA --es source "FINGERPRINT_PRESENCE"
    sleep 2
    FINGERPRINT_PRESENCE="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FINGERPRINT_PRESENCE) -eq 1 ];then
    echo "RETURN=PASS"
    FINGERPRINT_PRESENCE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FINGERPRINT_PRESENCE = "FAIL" ];then
    #am broadcast -a com.focaltech.fingerprint.activity.CQA --es source "FINGERPRINT_ABSENCE_STOP"
    echo "RETURN=ABSENCE"		
   # echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    FINGERPRINT_ABSENCE  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function FINGERPRINT_ABSENCE
{
	# insert your code below
	  #am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE FINGERPRINT --es CQA_TEST_FUNCTION FINGERPRINT_ABSENCE
		am broadcast -a com.focaltech.fingerprint.activity.CQA --es source "FINGERPRINT_ABSENCE"
    sleep 2
    FINGERPRINT_ABSENCE="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FINGERPRINT_ABSENCE) -eq 1 ];then
    echo "RETURN=PASS"
    FINGERPRINT_ABSENCE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FINGERPRINT_ABSENCE = "FAIL" ];then
    #am broadcast -a com.focaltech.fingerprint.activity.CQA --es source "FINGERPRINT_ABSENCE_STOP"
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
    
}

####################################################################
# Function:    FINGERPRINT_CHECK  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function FINGERPRINT_CHECK
{
	# insert your code below
    sleep 1
    FINGERPRINT_CHECK="FAIL"
    for i in $(seq 6 -1 1)
    do
    if [ $(getprop persist.sys.FINGERPRINT_ABSENCE) -eq 1 ];then
    echo "RETURN=PASS"
    FINGERPRINT_CHECK="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $FINGERPRINT_CHECK = "FAIL" ];then
    echo "RETURN=ERROR"			
    fi
    
}

####################################################################
# Function:    TOUCHPANEL_SELFTEST  		          	           #
# Description: This function should perform the selftest of Touch  #
#			   panel desired by ODM like open, short, relative 	   #
#              capacitance, number of rows and columns			   #
#		 Note: This test should be executed automatically without  #
#			   any operator interaction						       #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function TOUCHPANEL_SELFTEST
{
	# insert your code below
	RET=$(cat /sys/class/leds/lcd-backlight/brightness)
	if [ $RET -eq 0 ];then
	input keyevent 26
	fi
	sleep 2
	cat /sys/bus/i2c/devices/0-0038/fts_test
	sleep 2
}

####################################################################
# Function:    TOUCH_FIRMWARE_UPDATE  		          	           #
# Description: This function should force the TP firmware upgrade  #
#		 Note: If desired by ODM, this test can check the Touch    #
#			   panel firmware and update only if out of date or    #
#			   corrupted, but the response should reflect the      #
#			   action like (OK/UPDATED/ERROR)					   #
# Inputs:      N/A										   		   #
# Output:      STATUS: OK/UPDATED/ERROR					   		   # 
####################################################################
function TOUCH_FIRMWARE_UPDATE
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    TOUCHPANEL_VENDOR_ID  		          	           #
# Description: This function should return the touch panel vendor  #
# Inputs:      N/A										   		   #
# Output:      OK,vendor ID/ERROR					 	  		   # 
####################################################################
function TOUCHPANEL_VENDOR_ID
{
	# insert your code below
	RET=$(cat /sys/bus/i2c/devices/0-0038/fts_vendor_id)
	echo $RET
}

####################################################################
# Function:    DISPLAY_VENDOR_ID  		          	               #
# Description: This function should return the display panel vendor#
# Inputs:      N/A										   		   #
# Output:      OK,vendor ID/ERROR					 	  		   # 
####################################################################
function DISPLAY_VENDOR_ID
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE VENDOR_ID --es CQA_TEST_FUNCTION DISPLAY_VENDOR_ID
    sleep 2
    DISPLAY_VENDOR_ID="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.DISPLAY_VENDOR_ID) = "0" ];then
    echo "wait..."
    else	
    echo "RETURN=PASS,$(getprop persist.sys.DISPLAY_VENDOR_ID)"
    DISPLAY_VENDOR_ID="OK"
    break
    fi
    sleep 1
    done
    if [ $DISPLAY_VENDOR_ID = "FAIL" ];then
    echo "RETURN=ERROR"		
    #echo "feature $0 not implemented"		
    fi				
}

####################################################################
# Function:    NFC_SELFTEST         		          	           #
# Description: This function should perform the NFC selftests to   #
#			   verify the overall connectivity and functionality   #
#			   of the NFC antenna matching components, the NFC     #
#			   antenna, and the SWP line connected to the NFC SIM  #
#		 Note: This test requires NFC sim card and may return      #
#			   values like antenna AGC and TxLdo in case of antenna#
#		       specs evaluation requirement or simply selftest     #
#			   result (OK/ERROR)						   		   #
# Inputs:      N/A										   		   #
# Output:      OK,[NFC values if desired]/ERROR			  		   # 
####################################################################
function NFC_SELFTEST
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"			
}

####################################################################
# Function:    STAY_AWAKE_ON  		          	                   #
# Description: This function force the phone display to keep       #
#              enabled without timeout							   #
#		 Note: Key power button may disable the display normally   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function STAY_AWAKE_ON
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE STAY_AWAKE --es CQA_TEST_FUNCTION STAY_AWAKE_ON
    sleep 0.3
    STAY_AWAKE_ON="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.STAY_AWAKE_STATE) -eq 1 ];then
    echo "RETURN=PASS"
    STAY_AWAKE_ON="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $STAY_AWAKE_ON = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi				
}

####################################################################
# Function:    STAY_AWAKE_OFF  		          	                   #
# Description: This function returns the display timeout to the    #
#              normal status of disable time				       #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function STAY_AWAKE_OFF
{
	# insert your code below
	am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE STAY_AWAKE --es CQA_TEST_FUNCTION STAY_AWAKE_OFF
    sleep 0.3
    STAY_AWAKE_OFF="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.STAY_AWAKE_STATE) -eq 0 ];then
    echo "RETURN=PASS"
    STAY_AWAKE_OFF="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $STAY_AWAKE_OFF = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    ENABLE_AUDIO_ENHANCEMENT  		          	       #
# Description: This function should enable any audio enhancement,  #
#              if present, like Dolby Digital					   #
#		 Note: No splash screen or operator interaction should be  #
#			   required.										   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function ENABLE_AUDIO_ENHANCEMENT
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"	
}

####################################################################
# Function:    DISABLE_AUDIO_ENHANCEMENT  		          	       #
# Description: This function should disable any audio enhancement, #
#              if present, like Dolby Digital					   #
#		 Note: No splash screen or operator interaction should be  #
#			   required.										   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function DISABLE_AUDIO_ENHANCEMENT
{
	# insert your code below
    echo "feature $0 not implemented"
    echo "RETURN=FAIL"		
}

####################################################################
# Function:    DISABLE_AIRPLANE			  		          	       #
# Description: This function should disable the airplane mode      #
#		 Note: No splash screen or operator interaction should be  #
#			   required.										   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function DISABLE_AIRPLANE
{
	# insert your code below
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION DISABLE_AIRPLANE
		sleep 0.3
    DISABLE_AIRPLANE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.AIRPLANE_STATE) -eq 0 ];then
    echo "RETURN=PASS"
    DISABLE_AIRPLANE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $DISABLE_AIRPLANE = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
}

####################################################################
# Function:    ENABLE_AIRPLANE			  		          	       #
# Description: This function should enable the airplane mode       #
#		 Note: No splash screen or operator interaction should be  #
#			   required.										   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function ENABLE_AIRPLANE
{
	# insert your code below
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION ENABLE_AIRPLANE
		sleep 0.3
    ENABLE_AIRPLANE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.AIRPLANE_STATE) -eq 1 ];then
    echo "RETURN=PASS"
    ENABLE_AIRPLANE="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $ENABLE_AIRPLANE = "FAIL" ];then
    echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
    fi
}

####################################################################
# Function:    READ_TRACK_ID			  		          	       #
# Description: This function should return the track_id recorded   #
#			   at gsm.serial that matches with ADB Serial ID       #
# Inputs:      N/A										   		   #
# Output:      TRACK_ID		    						   		   # 
####################################################################
function READ_TRACK_ID
{
	# insert your code below
    READ_TRACK_ID="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop ro.serial) = "" ];then
    echo "wait..."
    else	
    echo "$(getprop ro.serial)"
    READ_TRACK_ID="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_TRACK_ID = "FAIL" ];then
    echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
    fi		
}

####################################################################
# Function:    READ_EMMC_SIZE			  		          	       #
# Description: This function should return the eMMC capacity       #
# Inputs:      N/A										   		   #
# Output:      OK,EMMC_SIZE [MBytes]/ERROR					       # 
####################################################################
function READ_EMMC_SIZE
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_EMMC_SIZE
    sleep 2
    READ_EMMC_SIZE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_EMMC_SIZE) = "0" ];then
    echo "wait..."
    else	
    echo "RETURN=PASS,EMMC_SIZE[$(getprop persist.sys.READ_EMMC_SIZE)]"
    READ_EMMC_SIZE="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_EMMC_SIZE = "FAIL" ];then
    echo "RETURN=ERROR"		
  #  echo "feature $0 not implemented"		
    fi				
}

####################################################################
# Function:    READ_RAM_LPDDR			  		          	       #
# Description: This function should return the RAM capacity        #
# Inputs:      N/A										   		   #
# Output:      OK,RAM_SIZE [MBytes]/ERROR					       # 
####################################################################
function READ_RAM_LPDDR
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_RAM_LPDDR
    sleep 2
    READ_RAM_LPDDR="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_RAM_LPDDR) = "0" ];then
    echo "wait..."
    else	
    echo "RETURN=PASS,RAM_SIZE[$(getprop persist.sys.READ_RAM_LPDDR)]"
    READ_RAM_LPDDR="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_RAM_LPDDR = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi				
}

####################################################################
# Function:    READ_SDCARD_SIZE			  		          	       #
# Description: This function should return the sdcard        #
# Inputs:      N/A										   		   #
# Output:      OK,SDCARD_SIZE [MBytes]/ERROR					       # 
####################################################################
function READ_SDCARD_SIZE
{
	# insert your code below
    am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_SDCARD_SIZE
    sleep 2
    READ_SDCARD_SIZE="FAIL"
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.READ_SDCARD_SIZE) = "0" ];then
    echo "wait..."
    else	
    echo "RETURN=PASS,SDCARD_SIZE[$(getprop persist.sys.READ_SDCARD_SIZE)]"
    READ_SDCARD_SIZE="OK"
    break
    fi
    sleep 1
    done
    if [ $READ_SDCARD_SIZE = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi				
}
####################################################################
# Function:    FACTORY_RESET			  		          	       #
# Description: This function should force the phone factory reset  #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function FACTORY_RESET
{
	# insert your code below
		dumpsys recovery reset
    #echo "feature $0 not implemented"
    #echo "RETURN=PASS"	
}

####################################################################
# Function:    DUAL_CAM_CALIBRATION
# Description: This function should use on dual camera phone
# Inputs:      N/A   		  
# Output:      status: 	OK/ERROR
####################################################################
function DUAL_CAM_CALIBRATION
{
    am start -n com.ape.camfaccalibration/com.ape.camfaccalibration.DualCamCalibration.DualCamVerify --es CQA_TEST_FUNCTION CALIBRATION
    sleep 2
    CALIBRATION_TEST="FAIL"

    for i in $(seq 30 -1 1)
    do
    if [ $(getprop persist.sys.CALIBRATION_TEST) = "4" ];then
    CALIBRATION_TEST="OK"
    echo "RETURN=PASS"
    break

    elif [ $(getprop persist.sys.CALIBRATION_TEST) = "2" ];then
    CALIBRATION_TEST="FAIL"
    break

    elif [ $(getprop persist.sys.CALIBRATION_TEST) = "1" ];then
    CALIBRATION_TEST="FAIL"
    break

    else	
    echo "wait..."
    fi
    sleep 5
    done

    if [ $CALIBRATION_TEST = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi	
}

####################################################################
# Function:    READ_SW_VERSION			  		          	             #
# Description: This function should return the SW_VERSION recorded #
#			         at ro.build.description                             #
# Inputs:      N/A										   		                       #
# Output:      SW_VERSION		    						   		                 # 
####################################################################
function READ_SW_VERSION
{
	# insert your code below
    echo "$(getprop ro.build.description)"	
  #  echo "feature $0 not implemented"		
}

#####################################################################
# Function:    READ_STANDBY_CURRENT				            #
# Description: This function should provide the real-time current   #
#			   flow on the phone battery.							#
#        Note: It is very important that the current value returned #
#              is as real-time as possible. This function will be   #
#		       called multiple times to measure stability           #
# Inputs:      N/A										   		    #
# Output:      OK,[battery current mA]/ERROR   			   			#
#####################################################################
function READ_STANDBY_CURRENT
{
		# enter airplane
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE AIRPLANE --es CQA_TEST_FUNCTION ENABLE_AIRPLANE
		sleep 0.3
    for i in $(seq 5 -1 1)
    do
    if [ $(getprop persist.sys.AIRPLANE_STATE) -eq 1 ];then
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done

    # Disable charging
    echo "0" > "/sys/class/power_supply/charger/charge_enabled"

    # turn screen off
    RET=$(cat /sys/class/leds/lcd-backlight/brightness)
    if [ $RET -ne 0 ];then
    input keyevent 26
    fi
    
    echo "wait 5 seconds ..."
    sleep 5
    
		# return standby current
    RET=$(cat sys/class/power_supply/battery/current_now)
    echo $RET
}

####################################################################
# Function:    OTG			  		          	       #
# Description: This function should return the OTG        #
# Inputs:      N/A										   		   #
# Output:      OK				       # 
####################################################################
function OTG
{
	# insert your code below
    #am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE READ_FLASH --es CQA_TEST_FUNCTION READ_SDCARD_SIZE
    sleep 1
    OTG="FAIL"
    for i in $(seq 2 -1 1)
    do
    if [ $(getprop persist.sys.OTG) = "1" ];then
    echo "RETURN=PASS"
    OTG="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 1
    done
    if [ $OTG = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi				
}

####################################################################
# Function:    ENABLE_CAMERA_FLASH  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function ENABLE_CAMERA_FLASH
{
	# insert your code below
		am start -n com.ape.factory/.CQAtest.CQAActivity --es CQA_TEST_MODE CAMERA_FLASH --es CQA_TEST_FUNCTION ENABLE_CAMERA_FLASH
    sleep 2
		ENABLE_CAMERA_FLASH="FAIL"
    for i in $(seq 10 -1 1)
    do
    if [ $(getprop persist.sys.CAMERA_FLASH) -eq 1 ];then
    echo "RETURN=PASS"
    ENABLE_CAMERA_FLASH="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 0.5
    done
    if [ $ENABLE_CAMERA_FLASH = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
    
}


####################################################################
# Function:    DISABLE_CAMERA_FLASH  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function DISABLE_CAMERA_FLASH
{
	# insert your code below
		am broadcast -a com.ape.factory.camera.closeCQA --es source "FINGERPRINT_ABSENCE_STOP"
    sleep 2
		DISABLE_CAMERA_FLASH="FAIL"
    for i in $(seq 10 -1 1)
    do
    if [ $(getprop persist.sys.CAMERA_FLASH) -eq 0 ];then
    echo "RETURN=PASS"
    DISABLE_CAMERA_FLASH="OK"
    break
    else	
    echo "wait..."
    fi
    sleep 0.5
    done
    if [ $DISABLE_CAMERA_FLASH = "FAIL" ];then
    echo "RETURN=ERROR"		
   # echo "feature $0 not implemented"		
    fi
    
}


####################################################################
# Function:    CLEAR_CQA_APPLICATIONS  		          	           #
# Description: This function should perform the selftest of FPS    #
#			   sensor. 											   #
#		 Note: It should not require finger. Only selftest 		   #
# Inputs:      N/A										   		   #
# Output:      status: 	OK/ERROR   						   		   # 
####################################################################
function CLEAR_CQA_APPLICATIONS
{
	# insert your code below
		am force-stop com.ape.factory
    am force-stop com.mediatek.engineermode
    am force-stop com.android.fmradio 
    echo "RETURN=PASS"
}
##### Main #####
eval $@
