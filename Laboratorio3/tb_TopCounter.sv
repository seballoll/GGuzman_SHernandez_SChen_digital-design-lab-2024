//module tb_TopCounter;
//
//    // Señales de prueba
//    logic clk;
//    logic rst;
//    logic [3:0] current_state;
//    logic [3:0] next_state;
//    logic finished;
//    logic [3:0] count;
//
//    // Instanciamos el DUT (Device Under Test)
//    TopCounter dut (
//        .clk(clk),
//        .rst(rst),
//        .current_state(current_state),
//        .next_state(next_state),
//        .finished(finished),
//        .count(count)
//    );
//
//    // Generar reloj de 50 MHz (20ns por ciclo)
//    initial begin
//        clk = 0;
//        forever #10 clk = ~clk;  // 50 MHz -> 20 ns por ciclo
//    end
//
//    // Simulación de prueba
//    initial begin
//        // Inicialización de señales
//        rst = 1;
//        current_state = 4'b0000;
//        next_state = 4'b0000;
//
//        // Esperar algunos ciclos de reloj
//        #100 rst = 0;  // Quitar el reset después de 100 ns
//
//        // Imprimir encabezado de los valores
//        $display("Tiempo: %0t | Estado Actual: %b | Contador: %0d | Finalizado: %b", $time, current_state, count, finished);
//
//        // Mantener el estado 0001 para permitir que el contador funcione
//        current_state = 4'b0001;
//
//        // Esperar hasta que el contador llegue a 15
//        repeat (15) begin
//            // Esperar 50 millones de ciclos (1 segundo en tiempo real)
//            #50000000;
//            // El estado 0001 permite incrementar el contador
//            current_state = 4'b0001;
//
//            // Imprimir el valor del contador en cada ciclo
//            $display("Tiempo: %0t | Estado Actual: %b | Contador: %0d | Finalizado: %b | counter15: %d" , $time, current_state, count, finished, dut.counter15);
//        end
//
//        // Detener la simulación
//        $stop;
//    end
//
//endmodule