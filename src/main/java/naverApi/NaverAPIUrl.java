package naverApi;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

public class NaverAPIUrl {

    private static final String BASE_URL = "https://openapi.naver.com/v1/search/shop.xml?";
    private static final String CLIENT_ID = "S7Flt8fVBUy2mjiKFIl8";
    private static final String CLIENT_SECRET = "67hyX1dP0T";

    private String query;

    public NaverAPIUrl(String query) {
        try {
            this.query = URLEncoder.encode(query, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패", e);
        }
    }

    public String getUrl() {
        return BASE_URL + "query=" + query;
    }

    public String getClientId() {
        return CLIENT_ID;
    }

    public String getClientSecret() {
        return CLIENT_SECRET;
    }
}
