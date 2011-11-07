//
//  SettingViewController.m
//  LoginShoes
//
//  Created by Yi Shen on 10/20/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingViewController.h"

@implementation SettingViewController
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Settings", @"Settings");
        //self.tabBarItem.image = [UIImage imageNamed:@"setting"];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setMyTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    cell.accessoryType = UITableViewCellAccessoryNone;
  }
  
  // Configure the cell...
  UITextField *playerTextField = [[[UITextField alloc] initWithFrame:CGRectMake(120, 10, 185, 30)] autorelease];
  playerTextField.adjustsFontSizeToFitWidth = YES;
  playerTextField.Enabled = YES;
  playerTextField.textColor = [UIColor blackColor];
  playerTextField.clearButtonMode = UITextFieldViewModeWhileEditing; // clear 'x' button to the right
  playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
  playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
  playerTextField.textAlignment = UITextAlignmentLeft;
  playerTextField.delegate = self;
  
  int section = [indexPath section];
  int row = [indexPath row];
  if (section == 0) {
    
    if (row == 0) {
      playerTextField.placeholder = @"example@gmail.com";
      playerTextField.keyboardType = UIKeyboardTypeEmailAddress;
      playerTextField.returnKeyType = UIReturnKeyDone;
      playerTextField.tag = 0;
      playerTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
      cell.textLabel.text = NSLocalizedString(@"email", @"email");
    }
    else {
      playerTextField.placeholder = @"Required";
      playerTextField.keyboardType = UIKeyboardTypeDefault;
      playerTextField.returnKeyType = UIReturnKeyDone;
      playerTextField.secureTextEntry = YES;
      playerTextField.tag = 1;
      playerTextField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
      cell.textLabel.text = NSLocalizedString(@"password", @"password");
    }
  }else{
    playerTextField.placeholder = @"placeholder";
    playerTextField.keyboardType = UIKeyboardTypeDefault;
    playerTextField.returnKeyType = UIReturnKeyDone;
    //playerTextField.tag = 2;
    cell.textLabel.text = @"test";
  }
  
  [cell addSubview:playerTextField];
  
  return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    // save settings here....
    if (textField.text.length > 0) {
        if (textField.tag ==0) {
            NSLog(@"saving settings for email");
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"email"];
        }else if (textField.tag ==1) {
            NSLog(@"saving settings for password");            
            [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"password"];
        }
    }
    
    return YES;
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *result = nil;
    if ( section == 0){
        result = @"Account:"; 
    }else{
        result = @"Others:"; 
    }
    return result; 
}

- (NSString *) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *result = nil;
    if (section == 0){
        result = @"Account Footer"; 
    }else{
        result = @"Others Footer"; 
    }
    return result; 
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    [myTableView release];
    [super dealloc];
}
@end
