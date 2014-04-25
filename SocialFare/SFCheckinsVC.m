//
//  SFCheckinsVC.m
//  SocialFare
//
//  Created by Josh Moore on 4/23/14.
//  Copyright (c) 2014 SocialFare. All rights reserved.
//

#import "DataModel/Checkin.h"

#import "SFCheckinsVC.h"
#import "SFFriendsCell.h"

@interface SFCheckinsVC () {
    NSArray *checkins;
}

@end

@implementation SFCheckinsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadCheckins];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [checkins count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    SFFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[SFFriendsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Checkin *checkin = (Checkin *)checkins[indexPath.row];
    Friend *friend = checkin.friend;
    
//    [cell.imageView setImageWithURL:[NSURL URLWithString:checkins.picture]
//                   placeholderImage:[UIImage imageNamed:@"no_avatar"]];
    
    cell.textLabel.text = checkin.name;
    cell.detailTextLabel.text = friend.name;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - data fetching

- (void)loadCheckins {
    //    [SVProgressHUD showWithStatus:@"Loading..."
    //                         maskType:SVProgressHUDMaskTypeBlack];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSPredicate *userFilter = [NSPredicate predicateWithFormat:@"user_id = %@", [SFFunctions userFacebookID]];
        checkins = [Checkin MR_findAllSortedBy:@"name" ascending:YES withPredicate:userFilter];
        NSLog(@"checkin count: %lu", (unsigned long)[checkins count]);
        [self.tableView reloadData];
        
        //        [SVProgressHUD dismiss];
    });
}

@end
