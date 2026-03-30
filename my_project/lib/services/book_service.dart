import 'package:my_project/models/book_model.dart';

class BookService {
  Future<List<Book>> initsData() async {
    if (Book.allBooks.isNotEmpty) {
      return Book.allBooks;
    }
    await Future.delayed(const Duration(seconds: 1));

    List<Book> mockData = [
      Book(
        id: "1",
        title: "Dế Mèn Phiêu Lưu Ký",
        author: "Tô Hoài",
        image:
            "https://images.unsplash.com/photo-1589923188900-85dae523342b?q=80&w=500",
        category: "Văn học",
        status: "reading",
        isFav: true,
        content:
            "CHƯƠNG 1: TÔI SỐNG ĐỘC LẬP TỪ THUỞ BÉ\n\n"
            "Bởi tôi ăn uống điều độ và làm việc có chừng mực nên tôi chóng lớn lắm. Chẳng bao lâu, tôi đã trở thành một chàng dế thanh niên cường tráng. Đôi càng tôi mẫm bóng. Những cái vuốt ở chân, ở khoeo cứ cứng dần và nhọn hoắt. Sang lắm! Mỗi khi tôi tập đường kiếm, những cái vuốt ấy cứ gạt ra lia lịa, trông thật là oai.\n\n"
            "Tôi đi đứng oai vệ. Mỗi bước đi, tôi làm điệu dún dẩy các khoeo chân, rung lên rung xuống hai chiếc râu. Cho đến khi tôi đi dạo, đôi cánh tôi trước kia ngắn hủn hoẳn bây giờ thành cái áo dài kín xuống tận chấm đuôi. Mỗi khi tôi vũ lên, đã nghe tiếng phành phạch giòn giã. Tôi lấy làm hãnh diện với bà con về cặp râu của mình lắm. Nó dài và uốn cong một vẻ rất đỗi hùng dũng. Tôi thường cẩn thận dùng đôi chân trước vuốt râu cho thẳng thắn và mượt mà.\n\n"
            "Mẹ tôi là một người phụ nữ lo xa. Bà bảo: 'Con ạ, con đã lớn, con phải tự lập thân. Đừng dựa dẫm vào mẹ mãi'. Thế là bà đào cho tôi một cái hang nhỏ ở ven ruộng, cho tôi một ít lương thực và bảo tôi tự đi mà kiếm sống. Những ngày đầu sống một mình, tôi thấy vừa sợ vừa thú vị. Sợ vì đêm tối vắng vẻ, thú vị vì mình được làm chủ cả một giang sơn nhỏ bé.\n\n"
            "CHƯƠNG 2: BÀI HỌC ĐẦU ĐỜI ĐAU XÓT\n\n"
            "Cạnh nhà tôi có anh Dế Choắt. Anh ta gầy gò, yếu ớt, lại còn lười nhác nữa. Tôi khinh anh ta lắm. Một hôm, vì muốn chứng tỏ cái oai của mình, tôi đã trêu chọc chị Cốc. Tôi hát một bài hát chế giễu chị rồi lẻn nhanh vào hang. Chị Cốc tức giận không thấy tôi đâu, bèn trút giận lên đầu anh Dế Choắt tội nghiệp.\n\n"
            "Cái mỏ sắt nhọn hoắt của chị Cốc giáng xuống lưng Choắt. Choắt không chịu nổi, nằm thoi thóp. Khi chị Cốc bay đi, tôi mới dám bò ra. Nhìn Choắt đang hấp hối, tôi hối hận vô cùng. Trước khi nhắm mắt, Choắt nói với tôi: 'Ở đời mà có thói hung hăng bậy bạ, có óc mà không biết nghĩ, sớm muộn rồi cũng mang vạ vào mình thôi'.\n\n"
            "Tôi đứng lặng trước xác người bạn láng giềng. Tôi đào cho anh một cái huyệt thật sâu, đắp thành nấm mộ đẹp. Đó là bài học đắt giá nhất mà tôi phải trả bằng cả mạng sống của một người khác. Tôi thề sẽ từ bỏ thói kiêu căng, ngạo mạn để sống một cuộc đời có ích hơn. Tôi quyết định sẽ đi du hành khắp thế gian để mở mang tầm mắt...",
      ),
      Book(
        id: "2",
        title: "Mắt Biếc",
        author: "Nguyễn Nhật Ánh",
        image:
            "https://images.unsplash.com/photo-1476275466078-4007374efbbe?w=500",
        category: "Văn học",
        status: "reading",
        isFav: false,
        content:
            "PHẦN 1: KÝ ỨC LÀNG ĐO ĐO\n\n"
            "Làng Đo Đo trong tâm trí tôi luôn là một màu xanh ngắt của những đồi sim và màu đỏ rực của những trưa hè nắng cháy. Ở đó, tôi có một người bạn thân nhất, một người mà cả đời này tôi không thể quên - Hà Lan. Hà Lan có đôi mắt biếc, đôi mắt mà nội tôi thường bảo là đôi mắt chứa đựng cả một bầu trời tâm sự.\n\n"
            "Chúng tôi đã cùng nhau lớn lên dưới bóng cây đa đầu làng, cùng nhau chơi trò rước đèn trung thu bằng lon sữa bò cũ kỹ. Hà Lan xinh đẹp từ nhỏ, nét đẹp thanh tú và đôi mắt hút hồn khiến cậu bé Ngạn là tôi khi đó luôn muốn bảo vệ cô ấy trước những trò trêu chọc của đám con trai trong làng.\n\n"
            "PHẦN 2: THÀNH PHỐ VÀ NHỮNG BIẾN CỐ\n\n"
            "Khi lên cấp ba, Hà Lan chuyển lên thành phố ở nhà người bà con để tiếp tục học tập. Tôi ở lại làng thêm một thời gian rồi cũng lên theo. Nhưng thành phố đã làm thay đổi Hà Lan. Cô ấy bắt đầu yêu thích những bộ váy lộng lẫy, những quán cà phê ồn ào và đặc biệt là Dũng - một anh chàng lãng tử, giàu có nhưng đầy rẫy sự lừa dối.\n\n"
            "Tôi nhìn Hà Lan rơi vào vòng tay của Dũng mà lòng đau như cắt. Tôi biết Dũng không phải người tốt, nhưng Hà Lan đã bị vẻ hào nhoáng của anh ta làm lóa mắt. Nhiều lần tôi muốn nói với cô ấy, nhưng nhìn thấy nụ cười hạnh phúc trên môi Hà Lan, tôi lại im lặng. Tôi chỉ biết đứng từ xa, làm một 'gã khờ' trung thành, sẵn sàng xuất hiện mỗi khi cô ấy cần một bờ vai để khóc.\n\n"
            "PHẦN 3: SỰ RA ĐỜI CỦA TRÀ LONG\n\n"
            "Bi kịch ập đến khi Dũng bỏ rơi Hà Lan lúc cô đang mang thai. Hà Lan suy sụp hoàn toàn. Tôi là người duy nhất ở bên cạnh chăm sóc cô trong những ngày tháng tăm tối đó. Khi Trà Long chào đời, tôi yêu thương nó như con ruột của mình. Trà Long lớn lên, càng ngày càng giống mẹ, đặc biệt là đôi mắt biếc ấy.\n\n"
            "Tôi dành cả tuổi thanh xuân để chăm sóc Trà Long, đưa nó đi học, kể cho nó nghe về làng Đo Đo. Nhưng càng nhìn Trà Long, tôi lại càng thấy đau lòng vì hình bóng của Hà Lan quá sâu đậm. Cuối cùng, tôi nhận ra mình không thể mãi sống trong quá khứ. Một buổi sáng sớm, tôi lặng lẽ ra đi, để lại một bức thư cho Trà Long và Hà Lan. Tôi đi tìm một chân trời mới, nơi mà nỗi đau mang tên 'Mắt Biếc' không còn đeo bám tôi nữa...",
      ),
      Book(
        id: "3",
        title: "Đắc Nhân Tâm",
        author: "Dale Carnegie",
        image:
            "https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=500",
        category: "Kỹ năng",
        status: "completed",
        isFav: true,
        content:
            "CHƯƠNG 1: NGHỆ THUẬT ỨNG XỬ CĂN BẢN\n\n"
            "Muốn lấy mật thì đừng phá tổ ong. Đây là nguyên tắc vàng đầu tiên trong giao tiếp. Bạn có biết rằng 99% tội phạm trong nhà tù Sing Sing đều không bao giờ tự nhận mình là người xấu? Họ luôn có lý do để biện minh cho hành động của mình. Nếu những kẻ tội đồ còn không tự trách mình, thì những người bình thường bạn gặp hàng ngày cũng vậy.\n\n"
            "Chỉ trích là vô ích vì nó làm đối phương phải phòng thủ và tìm cách bào chữa. Chỉ trích còn nguy hiểm vì nó làm tổn thương lòng tự trọng và gây nên sự oán hận. Abraham Lincoln thời trẻ từng rất hay chỉ trích người khác, cho đến khi ông suýt phải trả giá bằng một cuộc đấu kiếm sinh tử. Từ đó, ông không bao giờ phê phán ai nữa.\n\n"
            "CHƯƠNG 2: SÁU CÁCH TẠO THIỆN CẢM\n\n"
            "Cách đơn giản nhất là: Hãy mỉm cười. Nụ cười không tốn kém gì nhưng lại mang lại rất nhiều giá trị. Nó làm giàu cho người nhận mà không làm nghèo người cho. Một nụ cười chỉ trong nháy mắt nhưng có thể để lại dấu ấn suốt đời. Nếu bạn không muốn mỉm cười, hãy ép mình phải làm điều đó. Hãy hành động như thể bạn đang hạnh phúc, và điều đó sẽ dẫn đến hạnh phúc thực sự.\n\n"
            "Nguyên tắc tiếp theo: Hãy nhớ tên của người khác. Đối với mỗi người, tên của họ là âm thanh êm đềm và quan trọng nhất trong bất kỳ ngôn ngữ nào. Việc quên tên hoặc viết sai tên người khác chứng tỏ bạn không coi trọng họ. Các nhà chính trị đại tài như Jim Farley có thể nhớ tên hàng ngàn người, và đó là bí quyết giúp ông thành công rực rỡ.\n\n"
            "CHƯƠNG 3: THUYẾT PHỤC NGƯỜI KHÁC THEO CÁCH CỦA BẠN\n\n"
            "Cách duy nhất để chiến thắng trong một cuộc tranh luận là hãy tránh nó. Chín mươi phần trăm các cuộc tranh luận kết thúc bằng việc mỗi bên càng tin tưởng hơn vào quan điểm của mình. Bạn không thể thắng một cuộc tranh luận. Nếu bạn thua, bạn thua. Nếu bạn thắng, bạn cũng vẫn thua vì bạn đã làm tổn thương lòng tự trọng của đối phương và khiến họ ghét bạn.\n\n"
            "Hãy tôn trọng ý kiến của người khác. Đừng bao giờ nói: 'Anh sai rồi'. Thay vào đó, hãy bắt đầu bằng: 'Tôi có thể sai. Chúng ta hãy cùng xem xét sự việc này'. Lời nói nhẹ nhàng bao giờ cũng có sức mạnh hơn sự giận dữ. Hãy biết lắng nghe và khuyến khích người khác nói về chính họ. Khi bạn làm được điều đó, bạn sẽ trở thành một thỏi nam châm thu hút mọi người xung quanh...",
      ),
      Book(
        id: "4",
        title: "Nhà Giả Kim",
        author: "Paulo Coelho",
        image:
            "https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=500",
        category: "Kỹ năng",
        status: "",
        isFav: false,
        content:
            "HÀNH TRÌNH BẮT ĐẦU\n\n"
            "Santiago là một cậu bé chăn cừu tại vùng Andalusia xinh đẹp. Cậu yêu những con cừu của mình, cậu biết tên từng con và hiểu cả tính cách của chúng. Nhưng trong thâm tâm, Santiago luôn khao khát được đi xa hơn những cánh đồng cỏ quen thuộc. Cậu thường đọc sách mỗi khi rảnh rỗi và mơ về những vùng đất lạ.\n\n"
            "Một đêm, khi ngủ dưới gốc cây sung già trong một nhà thờ đổ nát, cậu mơ thấy một đứa trẻ dẫn cậu tới Kim Tự Tháp Ai Cập và nói rằng ở đó có một kho báu khổng lồ. Giấc mơ lặp lại khiến cậu băn khoăn. Cậu tìm đến một bà lão thầy bói và sau đó là vua xứ Salem. Ông vua đã dạy cậu về 'Vận mệnh cá nhân' - điều mà mỗi người hằng mong ước đạt được khi còn trẻ.\n\n"
            "SA MẠC VÀ NHỮNG THỬ THÁCH\n\n"
            "Để thực hiện giấc mơ, Santiago đã bán đàn cừu và vượt biển sang Châu Phi. Ngay khi vừa đặt chân tới Tangier, cậu đã bị lừa sạch tiền. Không tuyệt vọng, cậu xin vào làm việc cho một cửa hàng pha lê. Nhờ sự sáng tạo và chăm chỉ, cậu đã giúp cửa hàng phát đạt và tích góp đủ tiền để tiếp tục hành trình xuyên sa mạc Sahara.\n\n"
            "Trên sa mạc, cậu gặp một chàng người Anh đang đi tìm nhà giả kim. Hai người đã có những cuộc trò chuyện sâu sắc về cuộc đời và các dấu hiệu của vũ trụ. Tại một ốc đảo, Santiago gặp Fatima và yêu cô ngay từ cái nhìn đầu tiên. Nhưng cậu nhận ra rằng tình yêu không bao giờ ngăn cản một người đi tìm vận mệnh của mình. Nếu cô ấy thực sự yêu cậu, cô ấy sẽ chờ cậu trở về.\n\n"
            "GẶP GỠ NHÀ GIẢ KIM\n\n"
            "Cuối cùng, cậu gặp được Nhà Giả Kim thực sự. Ông không dạy cậu cách biến chì thành vàng bằng hóa chất, mà dạy cậu cách lắng nghe tiếng nói của trái tim và tâm hồn của thế giới. Ông bảo: 'Trái tim cậu ở đâu, thì kho báu của cậu ở đó'.\n\n"
            "Trải qua bao hiểm nguy, khi đứng trước Kim Tự Tháp hùng vĩ, Santiago mới nhận ra một sự thật bất ngờ: Kho báu thực sự không nằm dưới cát vàng Ai Cập, mà nó nằm ngay tại chính nơi cậu đã bắt đầu cuộc hành trình. Nhưng nếu không đi, cậu sẽ không bao giờ hiểu được ngôn ngữ của vũ trụ và không bao giờ trở thành người mà cậu mong muốn. Cuộc hành trình chính là phần thưởng lớn nhất...",
      ),
      Book(
        id: "5",
        title: "Sherlock Holmes",
        author: "Arthur Conan Doyle",
        image:
            "https://images.unsplash.com/photo-1587837073080-448bc6a2329b?q=80&w=500",
        category: "Khoa học",
        status: "reading",
        isFav: true,
        content:
            "VỤ ÁN TẠI PHỐ BAKER\n\n"
            "Căn phòng số 221B phố Baker mịt mù khói thuốc. Sherlock Holmes ngồi bất động trên chiếc ghế bành, đôi mắt sắc lẹm nhìn chăm chằm vào bức tường. Watson, người bạn đồng hành trung thành, đang lật giở những tờ báo sáng nay. Đột nhiên, có tiếng gõ cửa dồn dập. Một vị khách lạ mặt bước vào, gương mặt tái nhợt vì sợ hãi.\n\n"
            "Vị khách kể về một cái chết kỳ lạ trong một căn biệt thự bị khóa kín từ bên trong. Không có dấu hiệu của sự đột nhập, không có hung khí, và nạn nhân chết với một vẻ mặt kinh hoàng tột độ. Cảnh sát Scotland Yard hoàn toàn bế tắc. Holmes mỉm cười, một nụ cười chứa đựng sự tự tin tuyệt đối. 'Vụ này có vẻ thú vị đấy, Watson ạ. Chuẩn bị áo khoác đi, chúng ta lên đường thôi'.\n\n"
            "KHOA HỌC SUY LUẬN\n\n"
            "Khi đến hiện trường, Holmes không vội vàng xem xét xác chết. Ông bò dưới sàn nhà, dùng kính hiển vi soi từng hạt bụi, từng vết xước trên tay nắm cửa. 'Nhìn này Watson, kẻ sát nhân đi đôi giày cỡ 42, bị thọt chân trái và hút thuốc lá hiệu Trichinopoly'. Watson kinh ngạc: 'Làm sao anh biết được điều đó?'.\n\n"
            "Holmes giải thích: 'Đó là kết quả của sự quan sát tỉ mỉ và loại trừ những điều không thể. Khi anh đã loại bỏ những điều không thể, thì điều còn lại, dù vô lý đến đâu, cũng phải là sự thật'. Ông bắt đầu tái hiện lại hiện trường vụ án dựa trên những dấu vết nhỏ nhất. Kẻ thủ ác không ngờ rằng chính hơi ấm từ ống thông gió đã tiết lộ bí mật của hắn.\n\n"
            "CÁI BẪY HOÀN HẢO\n\n"
            "Holmes lập ra một cái bẫy tinh vi để dụ hung thủ lộ diện. Ông đóng giả thành một người làm vườn già nua để theo dõi nhất cử nhất động của các nghi phạm. Cuối cùng, trong đêm tối tĩnh mịch, hung thủ đã sa lưới. Đó là một người mà không ai có thể ngờ tới.\n\n"
            "Trở về phố Baker, Holmes lại tiếp tục với chiếc tẩu thuốc và bản nhạc violin quen thuộc. Đối với ông, phá án là một môn khoa học thuần túy, một cuộc đấu trí mà ở đó công lý luôn chiến thắng nhờ vào sự sáng suốt của tư duy. 'Vụ án đã kết thúc, nhưng câu đố của cuộc đời thì còn mãi', Holmes trầm ngâm nói...",
      ),
      // Tiếp tục cho các cuốn 6-10 với độ dài tương tự...
      Book(
        id: "6",
        title: "Vũ Trụ",
        author: "Carl Sagan",
        image:
            "https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=500",
        category: "Khoa học",
        status: "completed",
        isFav: true,
        content:
            "CHƯƠNG 1: BỜ BIỂN CỦA ĐẠI DƯƠNG VŨ TRỤ\n\n"
            "Vũ trụ là tất cả những gì đã, đang và sẽ tồn tại. Khi chúng ta suy ngẫm về vũ trụ, chúng ta cảm thấy một sự rùng mình nhẹ nhàng, một sự run rẩy nơi sống lưng, một giọng nói thì thầm, hay một cảm giác mờ nhạt như thể về một ký ức xa xăm. Đó là sự kinh ngạc trước cái vĩ đại vô biên.\n\n"
            "Trái đất của chúng ta chỉ là một hạt bụi nhỏ bé trôi dạt trong đại dương không gian bao la. Nếu vũ trụ là một đại dương, thì tất cả những gì chúng ta biết mới chỉ là đứng trên bờ và nhìn ra xa. Nhưng con người, với bộ não nhỏ bé của mình, đã dám tìm hiểu về nguồn gốc của các thiên hà, về cái chết của các ngôi sao và về sự khởi đầu của thời gian.\n\n"
            "CHƯƠNG 2: TIẾNG HÁT CỦA CÁC VÌ SAO\n\n"
            "Mỗi ngôi sao trên bầu trời là một mặt trời khác. Có những ngôi sao lớn gấp hàng ngàn lần mặt trời của chúng ta, và cũng có những ngôi sao đã chết, để lại những lỗ đen huyền bí. Chúng ta được cấu tạo từ chính 'vật liệu sao'. Các nguyên tử sắt trong máu, canxi trong xương của bạn đều được rèn luyện từ trung tâm của một ngôi sao khổng lồ đã nổ tung hàng tỷ năm trước.\n\n"
            "Sự khám phá vũ trụ không chỉ là một nhiệm vụ khoa học, nó còn là một hành trình tâm linh. Nó dạy chúng ta sự khiêm nhường. Khi nhìn từ không gian, Trái đất không có biên giới, không có xung đột sắc tộc, chỉ có một hành tinh xanh mong manh cần được bảo vệ. Carl Sagan đã nhắc nhở chúng ta rằng: 'Trong sự bao la của không gian và sự vô tận của thời gian, tôi rất hạnh phúc được chia sẻ một hành tinh và một kỷ nguyên với bạn'...",
      ),
      Book(
        id: "7",
        title: "Doraemon",
        author: "Fujiko F. Fujio",
        image:
            "https://images.unsplash.com/photo-1535905557558-afc4877a26fc?q=80&w=500",
        category: "Manga",
        status: "",
        isFav: false,
        content:
            "SỰ XUẤT HIỆN BẤT NGỜ\n\n"
            "Trong ngăn kéo bàn học của Nobita, một cái đầu tròn xoe, màu xanh dương đột ngột nhô lên. Đó là Doraemon, chú mèo máy đến từ thế kỷ 22. Đi cùng chú là Sewashi, chắt của Nobita. Họ đến để thay đổi tương lai bi đát của Nobita, người vốn dĩ sẽ thất bại trong mọi việc và để lại một món nợ khổng lồ cho con cháu.\n\n"
            "Doraemon sở hữu một chiếc túi thần kỳ chứa hàng ngàn bảo bối đến từ tương lai. Nobita, một cậu bé hậu đậu, lười học nhưng có trái tim ấm áp, bắt đầu những cuộc phiêu lưu mà cậu chưa từng dám mơ tới. Từ những việc nhỏ như dùng 'Bánh mì ghi nhớ' để đi thi, đến việc dùng 'Cỗ máy thời gian' để quay về quá khứ gặp bà nội.\n\n"
            "NHỮNG CUỘC PHIÊU LƯU ĐI VÀO HUYỀN THOẠI\n\n"
            "Không chỉ quanh quẩn trong thành phố Tokyo, Doraemon và nhóm bạn Nobita, Shizuka, Jaian, Suneo đã cùng nhau đi tới những nơi không tưởng. Họ đã xuống đáy biển sâu để tìm thành phố dưới nước, lên tận cung trăng để xây dựng vương quốc thỏ, và thậm chí là đi vào trong những trang sách truyện cổ tích.\n\n"
            "Mỗi bảo bối của Doraemon đều ẩn chứa một thông điệp. 'Cánh cửa thần kỳ' dạy chúng ta về khát khao được khám phá những chân trời mới. 'Đèn pin thu nhỏ' nhắc nhở chúng ta rằng đôi khi những điều nhỏ bé lại có sức mạnh phi thường. Tuy nhiên, Doraemon luôn dạy Nobita rằng bảo bối chỉ là công cụ hỗ trợ, còn sự nỗ lực của bản thân mới là điều quyết định thành công. Tình bạn giữa chú mèo máy và cậu bé hậu đậu đã trở thành biểu tượng vĩnh cửu của sự gắn kết và lòng vị tha...",
      ),
      Book(
        id: "8",
        title: "Lược Sử Thời Gian",
        author: "Stephen Hawking",
        image:
            "https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=500",
        category: "Khoa học",
        status: "reading",
        isFav: true,
        content:
            "BỨC TRANH VỀ VŨ TRỤ\n\n"
            "Hàng ngàn năm trước, con người tin rằng Trái đất là trung tâm của vũ trụ. Sau đó, Copernicus và Galileo đã chứng minh điều ngược lại. Nhưng vũ trụ còn phức tạp hơn thế nhiều. Stephen Hawking bắt đầu cuốn sách bằng cách đặt ra những câu hỏi cơ bản nhất: Thời gian có bắt đầu không? Vũ trụ có giới hạn không? Tại sao chúng ta lại nhớ quá khứ mà không nhớ tương lai?\n\n"
            "Ông dẫn dắt người đọc đi sâu vào Thuyết Tương Đối của Einstein, nơi mà không gian và thời gian bị uốn cong bởi vật chất. Bạn hãy tưởng tượng không gian như một tấm lưới cao su, và các ngôi sao là những quả cầu sắt nặng trĩu đặt lên đó. Sự uốn cong đó chính là cái mà chúng ta gọi là trọng lực.\n\n"
            "BÍ ẨN CỦA LỖ ĐEN\n\n"
            "Lỗ đen là những vùng không gian nơi trọng lực lớn đến mức ngay cả ánh sáng cũng bị giam cầm. Hawking đã đưa ra một phát hiện chấn động: Lỗ đen không hoàn toàn 'đen'. Chúng phát ra một loại bức xạ (nay gọi là bức xạ Hawking) và dần dần bốc hơi. Điều này mở ra một hướng đi mới để hợp nhất Thuyết Tương Đối và Cơ học Lượng tử - hai trụ cột của vật lý hiện đại đang mâu thuẫn với nhau.\n\n"
            "Dù cơ thể bị giam cầm bởi căn bệnh ALS, Hawking đã dùng trí tuệ siêu việt của mình để 'du hành' đến tận cùng của vũ trụ. Cuốn sách là một nỗ lực phi thường để giải thích những quy luật vĩ đại nhất của tự nhiên bằng một ngôn ngữ mà ai cũng có thể hiểu. Ông kết luận rằng nếu chúng ta tìm ra được 'Lý thuyết cuối cùng', chúng ta sẽ hiểu được tâm trí của Thượng đế...",
      ),
      Book(
        id: "9",
        status: "reading", // HIỆN Ở TAB ĐANG ĐỌC
        isFav: false,
        title: "Tôi Thấy Hoa Vàng Trên Cỏ Xanh",
        author: "Nguyễn Nhật Ánh",
        image:
            "https://images.unsplash.com/photo-1501446529957-6226bd447c46?q=80&w=500",
        category: "Văn học",
        content:
            "CHUYỆN VỀ HAI ANH EM\n\n"
            "Tôi là Thiều, anh trai của Tường. Tường là một đứa bé kỳ lạ, nó hiền lành, yêu động vật và có thể ngồi hàng giờ để nói chuyện với những con cóc dưới gầm giường. Làng quê nghèo của chúng tôi đầy rẫy những khó khăn nhưng cũng không thiếu những niềm vui nhỏ bé. Tôi thích cô bé Mận, nhưng sự ích kỷ và ghen tị đôi khi khiến tôi làm những điều khiến chính mình cũng phải hối hận.\n\n"
            "Tôi nhớ có lần vì ghen với Tường khi thấy nó thân thiết với Mận, tôi đã dùng một chiếc gậy đánh mạnh vào lưng nó. Tường không hề giận tôi, nó chỉ im lặng chịu đựng nỗi đau. Chính sự bao dung của đứa em trai đã làm tôi thức tỉnh. Tôi nhận ra rằng tình anh em là thứ quý giá hơn bất kỳ sự đố kỵ nào trên đời.\n\n"
            "NHỮNG MẢNH ĐỜI NƠI LÀNG QUÊ\n\n"
            "Cuốn sách không chỉ có hai anh em tôi, mà còn có chú Đàn với mối tình dang dở, có cha mẹ tôi với những lo toan cơm áo gạo tiền. Có những mùa lụt trắng đồng, mọi người phải dìu dắt nhau đi lánh nạn. Những lúc đó, sự tử tế giữa người với người lại sáng lên lấp lánh như những bông hoa vàng rực rỡ.\n\n"
            "Có những câu chuyện về 'con ma' trong vườn chuối thực chất là một người cha điên loạn vì mất con, hay những nàng công chúa trong truyện cổ tích mà Tường hằng tin tưởng. Cuộc sống nơi làng quê hiện lên vừa khắc nghiệt vừa thơ mộng. Cuối cùng, điều đọng lại trong tôi không phải là những thiếu thốn về vật chất, mà là vẻ đẹp của tâm hồn, của những rung động đầu đời trong sáng và của sự tha thứ...",
      ),
      Book(
        id: "10",
        title: "Cha Giàu Cha Nghèo",
        author: "Robert Kiyosaki",
        image:
            "https://images.unsplash.com/photo-1592188657297-c6473609e988?q=80&w=500",
        category: "Kỹ năng",
        status: "",
        isFav: false,
        content:
            "HAI NGƯỜI CHA, HAI QUAN ĐIỂM\n\n"
            "Tôi có hai người cha: một người cha giàu và một người cha nghèo. Người cha nghèo là cha ruột của tôi, một người có học vấn cao, làm việc cho chính phủ nhưng luôn gặp khó khăn về tài chính. Người cha giàu là cha của bạn thân tôi, một người chưa học hết lớp 8 nhưng lại trở thành một trong những người giàu nhất vùng Hawaii.\n\n"
            "Người cha nghèo luôn nói: 'Ham mê tiền bạc là nguồn gốc của mọi điều ác'. Người cha giàu lại bảo: 'Thiếu thốn tiền bạc là nguồn gốc của mọi điều ác'. Sự khác biệt trong tư duy chính là thứ quyết định vận mệnh tài chính của mỗi người. Tôi đã chọn học theo người cha giàu, và đó là quyết định thay đổi cuộc đời tôi mãi mãi.\n\n"
            "BÀI HỌC VỀ TÀI SẢN VÀ TIÊU SẢN\n\n"
            "Người giàu mua tài sản, người nghèo và người trung lưu mua tiêu sản mà họ cứ ngỡ là tài sản. Tài sản là những thứ mang tiền vào túi bạn (như bất động sản cho thuê, cổ phiếu, doanh nghiệp). Tiêu sản là những thứ lấy tiền ra khỏi túi bạn (như xe hơi đời mới, nhà trả góp để ở). Đa số mọi người rơi vào cái bẫy 'Rat Race' - làm việc chăm chỉ, kiếm tiền, trả hóa đơn, rồi lại làm việc chăm chỉ hơn.\n\n"
            "Để thoát khỏi vòng quẩn quanh đó, bạn phải học cách để tiền làm việc cho mình thay vì làm việc vì tiền. Hãy đầu tư vào kiến thức tài chính. Đó là loại tài sản mạnh mẽ nhất. Đừng sợ thất bại, vì trong thế giới tài chính, nếu bạn không dám mạo hiểm, bạn sẽ không bao giờ có được sự tự do thực sự. Hãy bắt đầu từ những việc nhỏ nhất và luôn kiên trì với mục tiêu của mình...",
      ),
    ];

    Book.allBooks = mockData;

    return Book.allBooks;
  }

  List<Book> getLoadedBooks() => Book.allBooks;
}
