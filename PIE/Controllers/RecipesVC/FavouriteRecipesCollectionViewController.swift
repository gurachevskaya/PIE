//
//  FavouriteRecipesCollectionViewController.swift
//  PIE
//
//  Created by Karina on 8/26/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import Foundation

class FavouriteRecipesCollectionViewController: RecipesCollectionViewController {
    
    override func startLoading() {
        let fetchResult = RecipeEntity.fetchRecipes()
        for recipeEntity in fetchResult {
            let recipe = Recipe(uri: recipeEntity.uri!,
                                label: recipeEntity.label!,
                                image: recipeEntity.image!,
                                source: recipeEntity.sourse!,
                                url: recipeEntity.url!,
                                yield: Int(recipeEntity.yield),
                                dietLabels: recipeEntity.dietLabels!,
                                healthLabels: recipeEntity.healthLabels!,
                                ingredientLines: recipeEntity.ingredientLines!,
                                calories: recipeEntity.calories,
                                totalWeight: recipeEntity.totalWeight,
                                totalTime: Int(recipeEntity.totalTime))
            
            recipes.append(recipe)
        }
        collectionView.reloadData()
    }
}


//self.dataManager = [DataManager sharedManager];
//NSManagedObjectContext *context = [self.dataManager newBackgroundContext];
//
//self.videosArray = [NSMutableArray array];
//NSArray *array = [context executeFetchRequest:[Video fetchRequest] error:nil];
//for (Video *video in array) {
//    TedVideo *tedVideo = [TedVideo new];
//    tedVideo.duration = video.duration;
//    tedVideo.imageUrl = video.imageUrl;
//    tedVideo.info = video.info;
//    tedVideo.speaker = video.speaker;
//    tedVideo.title = video.title;
//    tedVideo.link = video.link;
//    tedVideo.downloadLink = video.downloadLink;
//    [self.videosArray addObject:tedVideo];
//}
//[self.tableView reloadData];
