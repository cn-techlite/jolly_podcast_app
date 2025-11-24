import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:jolly_podcast/core/components/helpers/endpoints.dart';
import 'package:jolly_podcast/core/components/helpers/globals.dart';
import 'package:jolly_podcast/core/components/utils/constants.dart';
import 'package:jolly_podcast/core/components/utils/error_handling.dart';
import 'package:jolly_podcast/core/features/discover/model/discover_podcast_model.dart';
import 'package:jolly_podcast/core/features/discover/model/single_podcast_model.dart';

class HomeService {
  // Single Podcast
  Future<PodcastDataModel> getPodcastData({required int podcastId}) async {
    PodcastDataModel data = PodcastDataModel();
    try {
      Map<String, String> headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${globals.token}',
      };
      var url = Uri.parse("${Endpoints.baseUrl}episodes/$podcastId");
      var response = await http.get(url, headers: headers2);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final item = json.decode(response.body);
        var data1 = SinglePodcastResponseModel.fromJson(
          item,
        ); // Mapping json response to our data model
        printData('Podcast Details', data);
        data = data1.data!.data!;
        return data;
      } else {
        printData('Podcast Details Error', response.body);
        return data;
      }
    } catch (e) {
      printData('Podcast Details Catch Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }

  // Trending Podcast
  Future<MainPodcastDataModel> getTrendingPodcastData({
    required int page,
    required int pageNo,
  }) async {
    MainPodcastDataModel data = MainPodcastDataModel();
    try {
      Map<String, String> headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${globals.token}',
      };
      var url = Uri.parse(
        "${Endpoints.baseUrl}episodes/trending?page=$page&per_page=$pageNo",
      );
      var response = await http.get(url, headers: headers2);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final item = json.decode(response.body);
        var data1 = PodcastResponseModel.fromJson(
          item,
        ); // Mapping json response to our data model
        printData('Trending Podcast', data);
        data = data1.data!.data!;
        return data;
      } else {
        printData('Trending Podcast Error', response.body);
        return data;
      }
    } catch (e) {
      printData('Trending Podcast Catch Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }

  // Editors Picks
  Future<PodcastDataModel> getEditorsPickPodcast() async {
    PodcastDataModel data = PodcastDataModel();
    try {
      Map<String, String> headers2 = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${globals.token}',
      };
      var url = Uri.parse("${Endpoints.baseUrl}episodes/editor-pick");
      var response = await http.get(url, headers: headers2);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final item = json.decode(response.body);
        var data1 = SinglePodcastResponseModel.fromJson(
          item,
        ); // Mapping json response to our data model
        printData('Episodes Editor-pick Podcast', data);
        data = data1.data!.data!;
        return data;
      } else {
        printData('Episodes Editor-pick Error', response.body);
        return data;
      }
    } catch (e) {
      printData('Episodes Editor-pick Catch Error', e.toString());
      return Future.error(handleHttpError(e));
    }
  }
}
