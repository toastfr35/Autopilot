#ifndef FREERTOS_CONFIG_H
#define FREERTOS_CONFIG_H


#define configUSE_PREEMPTION					1
#define configUSE_PORT_OPTIMISED_TASK_SELECTION	1
#define configUSE_IDLE_HOOK						0
#define configUSE_TICK_HOOK						0
#define configUSE_DAEMON_TASK_STARTUP_HOOK		0
#define configTICK_RATE_HZ						( 1000 ) /* In this non-real time simulated environment the tick frequency has to be at least a multiple of the Win32 tick frequency, and therefore very slow. */
#define configMINIMAL_STACK_SIZE				( ( unsigned short ) 70 ) /* In this simulated case, the stack only has to hold one small structure as the real stack is part of the win32 thread. */
#define configTOTAL_HEAP_SIZE					( ( size_t ) ( 100 * 1024 ) )
#define configMAX_TASK_NAME_LEN					( 12 )
#define configUSE_TRACE_FACILITY				0
#define configUSE_16_BIT_TICKS					0
#define configIDLE_SHOULD_YIELD					1
#define configUSE_MUTEXES						1
#define configUSE_RECURSIVE_MUTEXES				1
#define configQUEUE_REGISTRY_SIZE				20
#define configUSE_APPLICATION_TASK_TAG			1
#define configUSE_COUNTING_SEMAPHORES			1
#define configUSE_ALTERNATIVE_API				0
#define configUSE_QUEUE_SETS					1
#define configUSE_TASK_NOTIFICATIONS			1
#define configSUPPORT_STATIC_ALLOCATION			0
#define configCHECK_FOR_STACK_OVERFLOW			1
#define configUSE_MALLOC_FAILED_HOOK			1

/* Software timer related configuration options.  The maximum possible task
priority is configMAX_PRIORITIES - 1.  The priority of the timer task is
deliberately set higher to ensure it is correctly capped back to
configMAX_PRIORITIES - 1. */
#define configUSE_TIMERS						0
#define configTIMER_TASK_PRIORITY				( configMAX_PRIORITIES - 1 )
#define configTIMER_QUEUE_LENGTH				20
#define configTIMER_TASK_STACK_DEPTH			( configMINIMAL_STACK_SIZE * 2 )

#define configMAX_PRIORITIES					( 7 )

/* Run time stats gathering configuration options. */
unsigned long ulGetRunTimeCounterValue( void ); /* Prototype of function that returns run time counter. */
void vConfigureTimerForRunTimeStats( void );	/* Prototype of function that initialises the run time counter. */
#define configGENERATE_RUN_TIME_STATS			0
#define portCONFIGURE_TIMER_FOR_RUN_TIME_STATS() vConfigureTimerForRunTimeStats()
#define portGET_RUN_TIME_COUNTER_VALUE() ulGetRunTimeCounterValue()

/* Co-routine related configuration options. */
#define configUSE_CO_ROUTINES 					0
#define configMAX_CO_ROUTINE_PRIORITIES			( 2 )

/* This demo can use of one or more example stats formatting functions.  These
format the raw data provided by the uxTaskGetSystemState() function in to human
readable ASCII form.  See the notes in the implementation of vTaskList() within
FreeRTOS/Source/tasks.c for limitations. */
#define configUSE_STATS_FORMATTING_FUNCTIONS	0

/* Enables the test whereby a stack larger than the total heap size is requested. */
#define configSTACK_DEPTH_TYPE uint32_t

#define INCLUDE_vTaskPrioritySet				0
#define INCLUDE_uxTaskPriorityGet				0
#define INCLUDE_vTaskDelete						0
#define INCLUDE_vTaskCleanUpResources			0
#define INCLUDE_vTaskSuspend					1
#define INCLUDE_vTaskDelayUntil					1
#define INCLUDE_vTaskDelay						1
#define INCLUDE_uxTaskGetStackHighWaterMark		0
#define INCLUDE_uxTaskGetStackHighWaterMark2	0
#define INCLUDE_xTaskGetSchedulerState			0
#define INCLUDE_xTimerGetTimerDaemonTaskHandle	0
#define INCLUDE_xTaskGetIdleTaskHandle			0
#define INCLUDE_xTaskGetHandle					0
#define INCLUDE_eTaskGetState					0
#define INCLUDE_xSemaphoreGetMutexHolder		0
#define INCLUDE_xTimerPendFunctionCall			0
#define INCLUDE_xTaskAbortDelay					0


extern void vAssertCalled( unsigned long ulLine, const char * const pcFileName );

#endif /* FREERTOS_CONFIG_H */
