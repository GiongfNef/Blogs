---
description: cheatsheet túi tiền & cuộc sống :))))
---

# Logic bug shopee: Giảm 5-10% khi mua sản phẩm ?

#### Tản mạn

* Từ đầu năm đến giờ chủ yếu viết trên notion, bỏ bê github lâu quá nhân dịp 5/5 big sale shopee mình muốn viết vài dòng về ~~logic~~ mẹo vặt khi mua hàng shopee để giảm 10% với mọi mặc hàng :))))
* Nói logic bug cho vui vậy thôi, thật ra mình thấy nó giống một trick hơn. Đây là trải nghiệm khi mua 2 món hàng của mình, đọc để giải trí thôi :smile:

#### Điều mà ai cũng biết

* Bigsale hay đại giảm giá từ nhằm kích cầu sản lượng mua hàng không có gì quá là mới mẻ thông thường có thể giảm từ 10-50%

<figure><img src="../../.gitbook/assets/image (19).png" alt=""><figcaption></figcaption></figure>

* Vậy nếu có một cách nào đó để bạn giảm 10% giá trị đơn hàng mà không cần dùng mã giảm giá sau đó tiếp tục áp thêm mã giảm giá 50% và freeship toàn quốc thì sẽ như thế nào nhỉ ? Cùng tìm hiểu thử nào

#### Phương thức thanh toán&#x20;

* Phương thức thanh toán cũng rất đa dạng, phổ biến có thể kể đến như thanh toán khi nhận hàng và chuyển khoản, ngoài ra đối với Shoppe còn có ví ShopeePay có thể nạp tiền từ ngân hàng vào hoặc liên kết với tài khoản ngân hàng để được giảm giá

<figure><img src="../../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

* Thông thường khi dùng ví ShopeePay sẽ được giảm maximum là 40k (tất nhiên là đối với đơn hàng trên 40k) -> mua đơn vài củ để giảm 40k yeah yeah&#x20;

<figure><img src="../../.gitbook/assets/image (9).png" alt=""><figcaption></figcaption></figure>



#### Dịch vụ dành riêng cho khách hàng thân quen

* Thông thường khi mua lại một sản phẩm đã mua trước đó mình sẽ được hỗ trợ từ 5-10% giá tiền tùy vào hỗ trợ của cửa hàng (tùy vào shop nữa nha)
* Chính sách rất thú vị nhằm tri ân khách hàng cũ, tuy nhiên sẽ ra sao nếu là lần đầu tiên mua hàng nhưng vẫn nhận được chính sách này ?

<figure><img src="../../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

#### Tính năng chắc chắn là tÍnH NĂnG

*   Quay lại với ví ShopeePay, khi mua hàng ta được chọn lựa&#x20;

    <figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>
* Để confirm lại với bên thứ 3 ta cần nhập số điện thoại và thanh toán như bình thường là xong

<figure><img src="../../.gitbook/assets/image (25).png" alt=""><figcaption></figcaption></figure>

* Tuy nhiên, cùng đặt ra giả thuyết: chuyện gì sẽ xãy ra nếu ta bỏ qua bước này ?
* Cùng nhảy sang URL giỏ hàng để xem thử

<figure><img src="../../.gitbook/assets/image (24).png" alt=""><figcaption></figcaption></figure>

* Lúc này sản phẩm được đưa vào queue trong giỏ hàng và chờ thanh toán, sao dễ ăn zay được đúng hong
* Tuy nhiên lần 2, chuyện gì xãy ra nếu ta mua thêm sản phẩm khác vào lúc này ?

<figure><img src="../../.gitbook/assets/image (15).png" alt=""><figcaption></figcaption></figure>

* Yeah đúng vậy giờ đây chúng ta đã là khách hàng cũ và được hỗ trợ khoảng 5% từ 876k -> 826k cụ thể nữa là 50k đấy :)))))
* Vậy .... vậy ....  liệu ta có thể nâng impact không ? chuyện gì xãy ra nữa nếu ta lại dùng queue đang thanh toán và mua sản phẩm mới ? Phải chăng sẽ mua được sản phẩm 0đ ????

<figure><img src="../../.gitbook/assets/image (22).png" alt=""><figcaption></figcaption></figure>

* &#x20;Tỉnh ngủ đi bạn eiiii, như đã đề cập ở trên đây chỉ là sale của cửa hàng dành riêng cho khách hàng cũ, tức là giờ đây bạn được hỗ trợ và trừ thẳng tiền từ phía cửa hàng có vẻ sẽ nhiều hơn nếu mua số lượng lớn 100 cái chẳng hạn ...

> #### &#x20;Thật ra lỗi này chính là `logic bug - skip step`, các bạn có thể hiểu rõ hơn khi xem [video này](https://www.youtube.com/watch?v=Brhjs7LZ9PY) và hiểu rõ hơn khi làm lab [bypass via flawed state machine](https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-authentication-bypass-via-flawed-state-machine) trên portswigger

<figure><img src="../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

* Tiêu biểu như trên mình được hỗ trợ 17k khoản 9% từ shop
* Tuy nhiên do đây là hỗ trợ từ cửa hàng nên vẫn có thể áp dụng thêm các mã giảm giá khác và freeship&#x20;

<figure><img src="../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

* Về cơ bản lỗi này là do khi được đưa vào danh sách giỏ hàng chờ thanh toán có vẻ đã được xử lý là mua hàng và chuyển ngay về phía các shop
* Impact có vẻ không cao lắm nhưng chuyện gì xãy ra nếu ta mua sản phẩm với số tiền lớn hơn ?

#### Vậy thử đặt ra một giả thiết cho đơn hàng có trị giá lớn của một shop nào đó ... ?

* Quay lại với chiếc đồng hồ trên, dù không có tiền mua nhưng nhìn giảm gần 400k cũng khoái lắm,.... ước ai đó donate

<figure><img src="../../.gitbook/assets/image (20).png" alt=""><figcaption></figcaption></figure>

* Vậy đó trick nhỏ để được giảm từ 5-10% khi chưa áp mã giảm giá, mà xem để biết thôi nha đừng áp dụng tội người ta (dù mình đã thanh toán và nhận thành công 2 đơn hàng nhưng vẫn thấy ấy náy hic).

