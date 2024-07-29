#include <stdio.h>
#include <stdlib.h>
#include "FreeRTOS.h"
#include "task.h"


void vAssertCalled( unsigned long ulLine, const char * const pcFileName )
{
    ( void ) ulLine;
    ( void ) pcFileName;
    taskENTER_CRITICAL();
    printf( "ASSERT! Line %ld, file %s, GetLastError() %ld\r\n", ulLine, pcFileName, GetLastError() );
    fflush( stdout );
	exit(1);
}

void vApplicationMallocFailedHook( void )
{
    vAssertCalled( __LINE__, __FILE__ );
}

void vApplicationStackOverflowHook( TaskHandle_t pxTask,
                                    char * pcTaskName )
{
    ( void ) pcTaskName;
    ( void ) pxTask;
    vAssertCalled( __LINE__, __FILE__ );
}


/*-----------------------------------------------------------*/
/*-----------------------------------------------------------*/

#define TASK_FREQUENCY_MS  25  //  500 ~= 1Hz    50 ~= 10Hz      25 ~= 20Hz
#define TASK_FREQUENCY_HZ  20

TickType_t xBlockTime = TASK_FREQUENCY_MS;

// For running faster than real time
void freertos_set_max_speed(void)
{
  xBlockTime = 1;
}

static unsigned long long time_ms = 0;
unsigned long long get_time_ms (void) {return time_ms;}


// System Test
extern void SysTest_update(int hz);

void SysTest_task(void *pvParameters)
{
   portTickType xLastWakeTime = xTaskGetTickCount();
   for (;;) {
      time_ms += (1000 / TASK_FREQUENCY_HZ);
      SysTest_update(TASK_FREQUENCY_HZ);
      vTaskDelayUntil(&xLastWakeTime, xBlockTime);
   }
}

//----------------------------
// Autopilot tasks
//----------------------------
#define TASK(NAME) \
extern void NAME##_step(void); \
extern void NAME##_reset(void); \
void NAME##_task(void *pvParameters)\
{\
   portTickType xLastWakeTime = xTaskGetTickCount();\
   for (;;) {\
      NAME##_step();\
      vTaskDelayUntil(&xLastWakeTime, xBlockTime);\
   }\
}

TASK(AFDS)
TASK(CDU)
TASK(GCAS)
TASK(NAV)
TASK(GPS)
TASK(TMAP)

void FreeRTOS_start( void )
{
   CDU_reset();
   GPS_reset();
   TMAP_reset();
   AFDS_reset();
   GCAS_reset();
   NAV_reset();

   xTaskCreate(SysTest_task, (signed char*)"SysTest", configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+3), NULL);
   xTaskCreate(CDU_task,     (signed char*)"CDU",     configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);
   xTaskCreate(GPS_task,     (signed char*)"GPS",     configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);
   xTaskCreate(TMAP_task,    (signed char*)"TMAP",    configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);
   xTaskCreate(AFDS_task,    (signed char*)"AFDS",    configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);
   xTaskCreate(GCAS_task,    (signed char*)"GCAS",    configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);
   xTaskCreate(NAV_task,     (signed char*)"NAV",     configMINIMAL_STACK_SIZE, NULL, (tskIDLE_PRIORITY+2), NULL);

   vTaskStartScheduler();
   for( ; ; );
}
