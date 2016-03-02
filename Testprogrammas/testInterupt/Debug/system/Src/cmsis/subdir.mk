################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/Src/cmsis/system_stm32f4xx.c \
../system/Src/cmsis/vectors_stm32f411xe.c 

OBJS += \
./system/Src/cmsis/system_stm32f4xx.o \
./system/Src/cmsis/vectors_stm32f411xe.o 

C_DEPS += \
./system/Src/cmsis/system_stm32f4xx.d \
./system/Src/cmsis/vectors_stm32f411xe.d 


# Each subdirectory must supply rules for building sources it contributes
system/Src/cmsis/%.o: ../system/Src/cmsis/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


