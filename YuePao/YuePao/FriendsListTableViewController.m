//
//  FriendsListTableViewController.m
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "FriendsListTableViewController.h"
#import "FriendsListTableViewCell.h"
#import "prefix-header.h"

@interface FriendsListTableViewController ()
{
    FRIEDNS_LIST_TYPE listType;
    NSArray *arrList;
    NSString *requestUrl;
}

@end

@implementation FriendsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    switch (listType) {
        case FRIEDNS_LIST_TYPE_FOLLOW:
            self.navigationItem.title = @"我关注的人";
            requestUrl = kUrlFollowList;
            break;
        case FRIEDNS_LIST_TYPE_FOLLOWED:
            self.navigationItem.title = @"关注我的人";
            requestUrl = kUrlFollowedList;
            break;
        default:
            break;
    }
    [self getFriendsList];
    
}
-(instancetype)initWithListType:(FRIEDNS_LIST_TYPE)type
{
    self = [self init];
    listType = type;
    return self;
}
-(void)getFriendsList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        arrList = [[NSArray alloc] initWithArray:(NSArray*)responseObject];
        NSLog(@"get friendsList success!");
        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get friendsList net error!");
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return arrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsListTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"friendsCell"];
    if (!cell) {

        cell = [[[NSBundle mainBundle] loadNibNamed:@"FriendsListTableViewCell" owner:self options:nil] lastObject];
    }
    NSInteger row = indexPath.row;
    NSString *name = [NSString stringWithFormat:@"%@",[[arrList objectAtIndex:row] objectForKey:@"name"]];
    cell.name = name;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
