class StrUtil {
  static String trimAbstract(String src) {
    String abstractContent;
    if (src.length > 60) {
      abstractContent = src.substring(0, 60);
      int endIndex = abstractContent.lastIndexOf("。");
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("，");
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf(",");
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("\r\n") - 1;
      }
      if (endIndex == -1) {
        endIndex = abstractContent.lastIndexOf("\n") - 1;
      }
      if (endIndex <= 0) {
        endIndex = 60 - 1;
      }
      abstractContent = abstractContent.substring(0, endIndex + 1);
    } else {
      abstractContent = src;
    }
    return abstractContent;
  }

  static bool isEmpty(String? src) {
    if (src == null) {
      return true;
    }
    if (src.isEmpty) {
      return true;
    }
    return false;
  }
}
