//
//  ActivitiesListTableViewController.m
//  YuePao
//
//  Created by lime on 15/7/20.
//  Copyright (c) 2015年 weilaizhineng. All rights reserved.
//

#import "ActivitiesListTableViewController.h"
#import "prefix-header.h"
#import "ActivitiesListTableViewCell.h"

@interface ActivitiesListTableViewController ()
{
    ACTIVITIES_LIST_TYPE listType;
    NSArray *arrList;
    NSString *requestUrl;
}

@end

@implementation ActivitiesListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    switch (listType) {
        case ACTIVITIES_LIST_TYPE_PUBLISH:
            self.navigationItem.title = @"我发布的活动";
            requestUrl = kUrlPublishList;
            break;
        case ACTIVITIES_LIST_TYPE_PARTICIPATE:
            self.navigationItem.title = @"我参与的活动";
            requestUrl = kUrlParticipateList;
            break;
        default:
            break;
    }
    [self getActivitiesList];
}
-(instancetype)initWithListType:(ACTIVITIES_LIST_TYPE)type
{
    self = [self init];
    listType = type;
    return self;
}
-(void)getActivitiesList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html", nil];
    [manager POST:requestUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *responseDic = (NSDictionary*)responseObject;
        NSString *result = [responseDic objectForKey:@"result"];
        if ([result isEqualToString:kSuccess]) {
            
            NSLog(@"get activitiesList success!");
            arrList = [[NSArray alloc] initWithArray:(NSArray*)[responseDic objectForKey:@"data"]];
            [self.tableView reloadData];
        }
        else{
            NSLog(@"%@",[responseDic objectForKey:@"data"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"get activitiesList net error!");
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivitiesListTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"activitiesCell"];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ActivitiesListTableViewCell" owner:self options:nil] lastObject];
    }
    NSInteger row = indexPath.row;
    NSString *name = [NSString stringWithFormat:@"%@",[[arrList objectAtIndex:row] objectForKey:@"name"]];
    cell.name = name;
    return cell;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
