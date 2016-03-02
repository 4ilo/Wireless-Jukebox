################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../system/Src/newlib/_exit.c \
../system/Src/newlib/_sbrk.c \
../system/Src/newlib/_startup.c \
../system/Src/newlib/_syscalls.c \
../system/Src/newlib/assert.c 

CPP_SRCS += \
../system/Src/newlib/_cxx.cpp 

OBJS += \
./system/Src/newlib/_cxx.o \
./system/Src/newlib/_exit.o \
./system/Src/newlib/_sbrk.o \
./system/Src/newlib/_startup.o \
./system/Src/newlib/_syscalls.o \
./system/Src/newlib/assert.o 

C_DEPS += \
./system/Src/newlib/_exit.d \
./system/Src/newlib/_sbrk.d \
./system/Src/newlib/_startup.d \
./system/Src/newlib/_syscalls.d \
./system/Src/newlib/assert.d 

CPP_DEPS += \
./system/Src/newlib/_cxx.d 


# Each subdirectory must supply rules for building sources it contributes
system/Src/newlib/%.o: ../system/Src/newlib/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C++ Compiler'
	arm-none-eabi-g++ -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu++11 -fabi-version=0 -fno-exceptions -fno-rtti -fno-use-cxa-atexit -fno-threadsafe-statics -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/Src/newlib/%.o: ../system/Src/newlib/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

system/Src/newlib/_startup.o: ../system/Src/newlib/_startup.c
	@echo 'Building file: $<'
	@echo 'Invoking: Cross ARM C Compiler'
	arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -Og -fmessage-length=0 -fsigned-char -ffunction-sections -fdata-sections -ffreestanding -fno-move-loop-invariants -Wall -Wextra  -g3 -DDEBUG -DUSE_FULL_ASSERT -DSTM32F411xE -DUSE_HAL_DRIVER -DHSE_VALUE=96000000 -DOS_INCLUDE_STARTUP_INIT_MULTIPLE_RAM_SECTIONS -I"../Inc" -I"../system/Inc" -I"../system/Inc/cmsis" -I"../system/Inc/stm32f4-hal" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"system/Src/newlib/_startup.d" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


