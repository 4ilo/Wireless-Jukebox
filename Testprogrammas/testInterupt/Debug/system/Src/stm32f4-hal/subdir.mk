################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/Src/stm32f4-hal/stm32f4xx_hal.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_cortex.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_flash.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_gpio.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_iwdg.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_pwr.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_rcc.c \
../system/Src/stm32f4-hal/stm32f4xx_hal_uart.c 

OBJS += \
./system/Src/stm32f4-hal/stm32f4xx_hal.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_cortex.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_flash.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_gpio.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_iwdg.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_pwr.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_rcc.o \
./system/Src/stm32f4-hal/stm32f4xx_hal_uart.o 

C_DEPS += \
./system/Src/stm32f4-hal/stm32f4xx_hal.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_cortex.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_flash.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_gpio.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_iwdg.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_pwr.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_rcc.d \
./system/Src/stm32f4-hal/stm32f4xx_hal_uart.d 


# Each subdirectory must supply rules for building sources it contributes
system/Src/stm32f4-hal/%.o: ../system/Src/stm32f4-hal/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu11 -Wno-bad-function-cast -Wno-conversion -Wno-sign-conversion -Wno-unused-parameter -Wno-sign-compare -Wno-missing-prototypes -Wno-missing-declarations -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/Src/stm32f4-hal/stm32f4xx_hal_uart.o: ../system/Src/stm32f4-hal/stm32f4xx_hal_uart.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu11 -Wno-bad-function-cast -Wno-conversion -Wno-sign-conversion -Wno-unused-parameter -Wno-sign-compare -Wno-missing-prototypes -Wno-missing-declarations -MMD -MP -MF"$(@:%.o=%.d)" -MT"system/Src/stm32f4-hal/stm32f4xx_hal_uart.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


