package com.example.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

@RestController
public class ApiController {

	@ResponseBody
	@GetMapping(value = "/test2", produces = "application/html; charset=UTF-8")
	public String getExhibitionInfoWithImages()
			throws IOException, ParserConfigurationException, SAXException, JSONException {
		String key = "ILEuvHedm5Mts3ZpudoU8a9%2BDdaOwoecKJOjXjU%2B9ojDsxSn8dG%2BRugXbJrL4r4biQE3pvzrt4mCSa1caDW8Vw%3D%3D";
		JSONArray jsonArray = new JSONArray();

		try {
			String url = "http://www.culture.go.kr/openapi/rest/publicperformancedisplays/period" + "?ServiceKey=" + key
					+ "&rows=80";

			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(url);

			doc.getDocumentElement().normalize();

			NodeList nList = doc.getElementsByTagName("perforList");

			for (int temp = 0; temp < nList.getLength(); temp++) {
				Node nNode = nList.item(temp);
				Element eElement = (Element) nNode;

				List<String> title = getTagValues("title", eElement);
				List<String> place = getTagValues("place", eElement);
				List<String> startDate = getTagValues("startDate", eElement);
				List<String> endDate = getTagValues("endDate", eElement);
				List<String> realmName = getTagValues("realmName", eElement);
				List<String> area = getTagValues("area", eElement);
				List<String> thumbnailUrl = getTagValues("thumbnail", eElement);

				JSONObject jsonObj = new JSONObject();
				jsonObj.put("title", title);
				jsonObj.put("place", place);
				jsonObj.put("startDate", startDate);
				jsonObj.put("endDate", endDate);
				jsonObj.put("realmName", realmName);
				jsonObj.put("area", area);
				jsonObj.put("thumbnail", thumbnailUrl);
				jsonArray.put(jsonObj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return jsonArray.toString();
	}

	public static List<String> getTagValues(String tag, Element eElement) {
		List<String> results = new ArrayList<>();
		NodeList nlList = eElement.getElementsByTagName(tag);
		for (int i = 0; i < nlList.getLength(); i++) {
			Node node = nlList.item(i);
			if (node.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) node;
				results.add(element.getTextContent());
			}
		}
		return results;
	}
}