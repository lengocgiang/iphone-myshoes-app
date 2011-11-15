//
//  ShoppingCartViewController.m
//  MyShoes
//
//  Created by Congpeng Ma on 25/10/11.
//  Copyright (c) 2011 18m. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoesDetailViewController.h"
#import "ShoppingCartViewCell.h"
#import "MyShoesAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "Shoes.h"

@implementation ShoppingCartViewController

@synthesize shoppingCartListView;
@synthesize networkTool;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
  // Do any additional setup after loading the view from its nib.
  
  // Do any additional setup after loading the view from its nib.
  
  //Shopping cart table list view
  shoppingCartListView = [[[UITableView alloc] initWithFrame:CGRectMake(0.0f,0.0f,320.0f,400.0f) 
                                                       style:UITableViewStylePlain] autorelease];
  shoppingCartListView.delegate = self;
  shoppingCartListView.dataSource = self;  
  shoppingCartListView.backgroundColor = [UIColor clearColor];
  
  //Enable selection in edit mode only like alarm app
  shoppingCartListView.allowsSelection = NO;
  //shoppingCartListView.allowsSelectionDuringEditing = YES;
  
  [self.view addSubview:shoppingCartListView];
    
  //Add the edit button to navigation bar. When the button is pressed, shopping cart table goes to edit mode
  UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" 
                                                                 style:UIBarButtonItemStyleBordered 
                                                                target:self 
                                                                action:@selector(EditButtonAction:)];
  [self.navigationItem setRightBarButtonItem:editButton];
  [editButton release];
  
  //Add the network tookit in charge of http communication
  networkTool = [[NetworkTool alloc] init];
  
  objMan = [[HJObjManager alloc] init];
  
  NSString* cacheDirectory = [NSHomeDirectory() stringByAppendingString:@"/Library/Caches/imgcache/myshoes/"] ;
  HJMOFileCache* fileCache = [[[HJMOFileCache alloc] initWithRootPath:cacheDirectory] autorelease];
  objMan.fileCache = fileCache;

    
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    
  [objMan release];
  [networkTool release];
  [shoppingCartListView release];
  [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  //Refresh shopping cart list view
  [shoppingCartListView reloadData];
}

#pragma mark Table view methods

//Only one sections here
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Locate the shopping cart object in MyShoesApplicationDelegate
    id delegate = [[UIApplication sharedApplication] delegate];
    
    ShoppingCart *shoppingCart = nil;
    if ([delegate respondsToSelector:@selector(shoppingCart)]){
        shoppingCart = [delegate shoppingCart];
    }
    
    return [shoppingCart getCount];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  static NSString *CellIdentifier = @"CartCell";
  
  id cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    //cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    cell = [[[ShoppingCartViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
  }
  
  // Set up the cell...
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }
  
  Shoes *shoes = [shoppingCart getShoesAtIndex:indexPath.row];
  
  //imageView.image = shoes.shoesImage;
  NSString *imageName = shoes.shoesImageName;
  NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",MYSHOES_URL,imageName];
  
  NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
  //NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
  
  /*UIImage *shoesImage = [UIImage imageWithData: [NSData dataWithContentsOfURL: imageUrl]];
  
  CGSize sz = SHOES_LIST_IMG_SIZE;
  
  UIImage *resized = [HomeViewController scale:shoesImage toSize:sz];
  [cell imageView].image = resized;*/
  
  // To improve performance
  [[cell imageView] setOpaque:YES];
  CGRect frame;
	frame.size.width = CART_LIST_CELL_IMG_WIDTH;
  frame.size.height = CART_LIST_CELL_HEIGHT;
	frame.origin.x = 0;
  frame.origin.y = 0;
  HJManagedImageV *managedImage = [[[HJManagedImageV alloc] initWithFrame:frame] autorelease];
  managedImage.url = imageUrl;
  [objMan manage:managedImage];
  
  // To improve performance
  [managedImage setOpaque:YES];
  
	[[cell contentView] addSubview:managedImage];


  [cell setShoes:shoes];
  [cell setShoesInfo:shoes.productStyle];
  //If the shopping cart list view is not in edit mode, just show Image of the shoes
  if(!tableView.editing){
    [cell setEditing:NO];
    NSUInteger quantity = [shoppingCart getQuantity:indexPath.row];
    NSString *price = shoes.productPrice;
    
    [cell setShoesDetail:[NSString stringWithFormat:@"%@ %d", price, quantity]];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %d", price, quantity];
    //cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica" size:(10.0)];
    //cell.detailTextLabel.textAlignment = UITextAlignmentRight;
  }
  else
  {
    [cell setEditing:YES];
    [cell setShoesQuantity:[shoppingCart getQuantity:indexPath.row]];
  }

  //cell.editingStyle
  //cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  //View mode is just to view the list of shopping cart
  //Edit mode let user delete/modify items in shopping cart
  
  /*
  id delegate = [[UIApplication sharedApplication] delegate];
  
  ShoppingCart *shoppingCart = nil;
  if ([delegate respondsToSelector:@selector(shoppingCart)]){
    shoppingCart = [delegate shoppingCart];
  }

  //Here, we push a brand new ShoesDetailController instance since it's different than
  //the one from ShoesListView
  ShoesDetailViewController *shoesDetailView = [[[ShoesDetailViewController alloc]
                                                initWithNibName:@"ShoesDetailViewController"
                                                bundle:nil] autorelease];
  
  [shoesDetailView setShoes:[shoppingCart getShoesAtIndex:indexPath.row]];
  //Set the shoesDetailView to be editing mode
  //There is no more editing mode for shoesDetailView
  //[shoesDetailView setEditing:YES];
  [self.navigationController pushViewController:shoesDetailView animated:YES];*/
}

// Update the data model according to edit actions delete or insert.
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    id delegate = [[UIApplication sharedApplication] delegate];
    
    ShoppingCart *shoppingCart = nil;
    if ([delegate respondsToSelector:@selector(shoppingCart)]){
      shoppingCart = [delegate shoppingCart];
    }

    [shoppingCart removeShoesAtIndex:indexPath.row];
    [shoppingCartListView reloadData];
  } 
}

#pragma mark navigation bar button methods

- (void)EditButtonAction:(id)sender {
  if(shoppingCartListView.editing)
  {
    [shoppingCartListView setEditing:NO animated:NO];
    [shoppingCartListView reloadData];
    [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
  }
  else
  {
    [shoppingCartListView setEditing:YES animated:YES];
    [shoppingCartListView reloadData];
    [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    [self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
  }
  
  //[shoppingCartListView reloadData];
}

#pragma mark -
#pragma mark ShowView common methods

- (void)resetView{
  //Anything here need to clean this view
}

@end
