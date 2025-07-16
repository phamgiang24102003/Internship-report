# Mô tả testbench

Code trong thư mục test đang kiểm thử không sử dụng Randomization do hạn chế của công cụ Modelsim

Đây là link EDA Playground sử dụng công cụ Synopsys VCS: https://www.edaplayground.com/x/7x9c

Ảnh kết quả:
<img width="1863" height="880" alt="Screenshot 2025-07-16 134659" src="https://github.com/user-attachments/assets/6f3a352d-382f-4d86-8614-0a72eef76125" />

# Specification

<img width="711" height="296" alt="Screenshot 2025-07-16 000604" src="https://github.com/user-attachments/assets/35ea4095-9a5a-4280-b899-cf39152f2c5b" />

## DUT là một mô-đun chuyển đổi với các đặc điểm sau:

▪ Chuyển đổi tín hiệu dữ liệu 8-bit đầu vào thành tín hiệu dữ liệu 1-bit đầu ra (bộ chuyển đổi song song sang nối tiếp).

▪ Tín hiệu dữ liệu 8-bit (DATA_IN[7:0]) chỉ hợp lệ khi tín hiệu VALID ở mức cao.

▪ Tín hiệu đầu ra 1-bit có thể bao gồm một bit chẵn lẻ (parity bit) tùy thuộc vào cấu hình của PARITY_MODE[1:0].
<img width="960" height="454" alt="Screenshot 2025-07-16 003354" src="https://github.com/user-attachments/assets/ab07cd37-e632-4b38-b0c8-63a7fdcc3ce7" />
### Giải thích về chẵn lẻ (parity):
Trong truyền dữ liệu, “chẵn lẻ” là một phương pháp được sử dụng để kiểm tra lỗi trong dữ liệu truyền. Có hai kiểu chẵn lẻ chính: chẵn (even parity) và lẻ (odd parity).

▪ Chẵn lẻ chẵn: Mục tiêu là đảm bảo tổng số bit '1' trong dữ liệu cộng với bit chẵn lẻ là một số chẵn.

-->Ví dụ: Nếu dữ liệu là 1010001 (có 3 bit '1'), thì bit chẵn lẻ sẽ là 1 (vì 3 + 1 = 4 là số chẵn). Chuỗi dữ liệu sau khi thêm bit chẵn lẻ sẽ là 10100011.

▪ Chẵn lẻ lẻ: Mục tiêu là đảm bảo tổng số bit '1' trong dữ liệu cộng với bit chẵn lẻ là một số lẻ.

-->Ví dụ: Nếu dữ liệu là 1010001 (có 3 bit '1'), thì bit chẵn lẻ sẽ là 0 (vì 3 đã là số lẻ nên không cần thêm bit '1'). Chuỗi dữ liệu sẽ là 10100010.

### Giải thích về truyền nối tiếp trên chân TXD khi DATA_IN[7:0] hợp lệ:
Bit ít ý nghĩa nhất (LSB) sẽ được truyền trước.
<img width="664" height="423" alt="Screenshot 2025-07-16 001028" src="https://github.com/user-attachments/assets/ae8befd6-21b3-4f30-a689-513b61114ac4" />

### Giải thích về PARITY_MODE[1:0]:

▪ PARITY_MODE[1:0] = 2’b00 hoặc 2’b11: không chèn bit chẵn lẻ vào đầu ra.

▪ PARITY_MODE[1:0] = 2’b01 hoặc 2’b10: bit chẵn lẻ sẽ được chèn vào cuối cùng trên đường truyền TXD.

-->Ví dụ sau minh họa trường hợp PARITY_MODE = 2’b10.
<img width="653" height="362" alt="Screenshot 2025-07-16 001307" src="https://github.com/user-attachments/assets/5eddbe39-8390-46e4-9fb9-8b4ce50d6fa8" />

### Ví dụ: DATA_IN = 8'ha3, PARITY_MODE = 2’b01.
<img width="858" height="219" alt="Screenshot 2025-07-16 001347" src="https://github.com/user-attachments/assets/23598af7-4af3-4b95-b8e5-c129909e41d8" />
